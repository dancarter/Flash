class CardsController < AuthenticatedController

  def index
    @cards = current_user.cards
    @card = Card.find(params[:card_id]) unless params[:card_id].nil?
    respond_to do |format|
      format.html
      format.csv { render text: @cards.to_csv }
    end
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
      redirect_to cards_path, notice: 'Card was successfully created.'
    else
      @cards = current_user.cards - [@card]
      render :index
    end
  end

  def update
    @card = current_user.cards.find(params[:id])

    if @card.update(card_params)
      @card.tags = params[:card][:tag_ids].reject!{|x| x== ''}.map{|x| Tag.find(x.to_i)}
      redirect_to cards_path, notice: 'Card was successfully updated.'
    else
      @cards = current_user.cards
      render :index
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
