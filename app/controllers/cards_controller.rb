class CardsController < AuthenticatedController

  def index
    @cards = current_user.cards
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
      @card.tags = params[:card][:tag_ids].reject!{|x| x== ''}.map{|x| Tag.find(x.to_i)}
      @card.save!
      redirect_to root_path, notice: 'Card was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @card = current_user.cards.find(params[:id])

    if @card.update(card_params)
      @card.tags = params[:card][:tag_ids].reject!{|x| x== ''}.map{|x| Tag.find(x.to_i)}
      redirect_to root_path, notice: 'Card was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    current_user.cards.find(params[:id]).destroy
    redirect_to root_path, notice: 'Card was successfully deleted.'
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

end
