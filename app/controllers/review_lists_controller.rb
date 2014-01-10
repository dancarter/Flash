class ReviewListsController < AuthenticatedController

  def show
    @review_list = ReviewList.find(params[:id])
    if @review_list.review_list_cards.size > 0
      @card = @review_list.review_list_cards.first.card
      @review_list.review_list_cards.first.destroy
    else
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
    params.require(:review_list).permit(:amount, :tags => [])
  end

end
