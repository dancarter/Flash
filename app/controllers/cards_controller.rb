class CardsController < ApplicationController

  def index
    @cards = current_user.cards unless current_user.nil?
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
     @card = Card.new(card_params)
     @card.user_id = current_user.id

    if @card.save
      redirect_to @card, notice: 'Card was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_url
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

end
