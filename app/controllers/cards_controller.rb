class CardsController < ApplicationController

  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

end
