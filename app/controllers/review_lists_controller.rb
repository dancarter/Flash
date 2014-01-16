class ReviewListsController < AuthenticatedController

  def show
    @review_list = ReviewList.find(params[:id])
    if @review_list.review_list_cards.count > 0
      review_list_card = @review_list.review_list_cards.shuffle.first
      @card = review_list_card.card
      review_list_card.destroy
    else
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
    params.require(:review_list).permit(:amount, :tag_ids => [])
  end

end
