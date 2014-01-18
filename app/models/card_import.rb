class CardImport
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  require 'roo'

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save(user)
    if imported_cards(user).include?('Unknown')
      errors.add :base, imported_cards(user)
      false
    else
      if imported_cards(user).map(&:valid?).all?
        imported_cards(user).each(&:save!)
        true
      else
        imported_cards(user).each_with_index do |card, index|
          card.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end
        false
      end
    end
  end

  def imported_cards(user)
    @imported_cards ||= load_imported_cards(user)
  end

  def load_imported_cards(user)
    spreadsheet = open_spreadsheet
    if spreadsheet.include?('Unknown')
      spreadsheet
    else
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map { |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        card = Card.find_by_id(row["id"]) || Card.new
        if card.user.nil? || card.user == user
          card.attributes = row.to_hash.slice('front','back')
          card.user = user
          card
        end
      }.reject { |card| card.nil? }
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    else return "Unknown file type: #{file.original_filename}"
    end
  end
end
