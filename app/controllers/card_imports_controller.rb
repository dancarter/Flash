class CardImportsController < ApplicationController
  def new
    @card_import = CardImport.new
  end

  def create
    @card_import = CardImport.new(params[:card_import])
    if @card_import.save(current_user)
      redirect_to cards_path, notice: "Imported cards successfully."
    else
      render :new
    end
  end
end
