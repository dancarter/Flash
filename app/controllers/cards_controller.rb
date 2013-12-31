class CardsController < AuthenticatedController

  def index
    @cards = current_user.cards
  end

  def show
    @card = current_user.cards.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def edit
    @card = current_user.cards.find(params[:id])
  end

  def create
     @card = current_user.cards.build(card_params)

    if @card.save
      redirect_to new_card_path, notice: 'Card was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @card = current_user.cards.build(card_params)

    if @card.update(card_params)
      redirect_to cards_path, notice: 'Card was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    current_user.cards.find(params[:id]).destroy
    redirect_to cards_path, notice: 'Card was successfully deleted.'
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

end
