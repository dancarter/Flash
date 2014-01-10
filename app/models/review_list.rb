class ReviewList
  attr_reader :cards

  def initialize(amount, tags=[])
    @tags = tags
    @amount = amount
  end

  def setCards
    allCards = []
    if @tags.size > 0
      @tags.each do |tag|
        allCards << tag.cards
      end
    else
      allCards = current_user.cards
    end
    binding.pry
    @cards = allCards.flatten.sample(@amount)
  end

end
