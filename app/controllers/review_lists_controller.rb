class ReviewListsController < AuthenticatedController

  def show
    @review_list = ReviewList.find(params[:id])
    if @review_list.srs_review?
      if @review_list.review_list_cards.count > 0 && !params[:recall].nil?
        review_list_card = @review_list.review_list_cards.where(card_id: @review_list.last_card)[0]
        review_list_card.card.process_recall_result(params[:recall].to_i)
        review_list_card.card.save!
        if params[:recall].to_i > 2
          review_list_card.destroy
        end
      end
    else
      if @review_list.review_list_cards.count > 0
        if params[:repeat] == 'false' && !params[:repeat].nil?
          review_list_card = @review_list.review_list_cards.where(card_id: @review_list.last_card)
          review_list_card[0].destroy
        end
      end
    end
    @card = @review_list.next_card if @review_list.review_list_cards.count != 0
    if @review_list.review_list_cards.count == 0
      @review_list.destroy
      redirect_to review_path, notice: "Review Complete!"
    end
  end

  def new
    @review_list = ReviewList.new
  end

  def create
    @review_list = current_user.review_lists.build(review_list_params)

    if @review_list.save
      ReviewList.set_cards(@review_list, current_user)
      redirect_to review_list_path(@review_list)
    else
      render template: "pages/review"
    end
  end

  private

  def review_list_params
    params.require(:review_list).permit(:amount, :srs_review, :new_count, :tag_ids => [])
  end

end
