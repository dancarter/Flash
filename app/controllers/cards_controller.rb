class CardsController < AuthenticatedController

  def index
    @search = current_user.cards.search(params[:q])
    @cards = @search.result(distinct: true)
    unless params[:card_id].nil? || Card.find(params[:card_id]).user != current_user
      @card = Card.find(params[:card_id])
    end
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
      tag = eval(params[:card][:q])[:q]
      if tag
        filter = {}
        filter[:tags_id_eq] = tag["tags_id_eq"]
        redirect_to cards_path(q: filter), notice: 'Card was successfully created.'
      else
        redirect_to cards_path, notice: 'Card was successfully created.'
      end
    else
      @card.user = nil
      @search = current_user.cards.search(params[:q])
      @cards = @search.result(distinct: true)
      render :index
    end
  end

  def update
    @card = current_user.cards.find(params[:id])

    if @card.update(card_params)
      @card.tags = params[:card][:tag_ids].reject!{|x| x== ''}.map{|x| Tag.find(x.to_i)}
      tag = eval(params[:card][:q])[:q]
      if tag
        filter = {}
        filter[:tags_id_eq] = tag["tags_id_eq"]
        redirect_to cards_path(q: filter), notice: 'Card was successfully updated.'
      else
        redirect_to cards_path, notice: 'Card was successfully updated.'
      end
    else
      @search = current_user.cards.search(params[:q])
      @cards = @search.result(distinct: true)
      render :index
    end
  end

  def destroy
    current_user.cards.find(params[:id]).destroy
    redirect_to cards_path(q: params[:q]), notice: 'Card was successfully deleted.'
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

end
