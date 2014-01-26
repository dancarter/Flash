class ReviewListsController < AuthenticatedController

  def show
    @review_list = ReviewList.find(params[:id])
    if @review_list.last_card == nil && @review_list.cards.size == 0 && @review_list.srs_review?
      redirect_to review_path, notice: "No valid cards for SRS review!"
      @review_list.destroy
    elsif @review_list.last_card == nil && @review_list.cards.size == 0
      redirect_to review_path, notice: "No cards due after that date!"
      @review_list.destroy
    else
      @card, redirect = @review_list.review(params[:repeat],params[:recall])
      if redirect
        redirect_to review_path, notice: "Review Complete!"
      end
    end
  end

  def new
    @review_list = ReviewList.new
  end

  def create
    @review_list = current_user.review_lists.build(review_list_params)

    if @review_list.save
      @review_list.set_cards(current_user)
      redirect_to review_list_path(@review_list)
    else
      render template: "pages/review"
    end
  end

  private

  def review_list_params
    params.require(:review_list).permit(:amount, :srs_review, :new_count, :max, :due_after, :tag_ids => [])
  end

end
