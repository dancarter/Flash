class TagsController < AuthenticatedController

  def index
    @tags = current_user.tags
    unless params[:tag_id].nil? || Tag.find(params[:tag_id]).user != current_user
      @tag = Tag.find(params[:tag_id]) unless params[:tag_id].nil?
    end
    respond_to do |format|
      format.html
      format.csv { render text: @tag.to_csv }
    end
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = current_user.tags.find(params[:id])
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      redirect_to tags_path, notice: 'Tag was successfully created.'
    else
      @tags = current_user.tags - [@tag]
      render :index
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])

    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      @tags = current_user.tags
      render :index
    end
  end

  def destroy
    current_user.tags.find(params[:id]).destroy
    redirect_to tags_path, notice: 'Tag was successfully deleted.'
  end

  def remove
    @tag = Tag.find(params[:tag_id])
    @tag.taggings.each do |tagging|
      tagging.destroy
    end
    redirect_to tags_tag_path(@tag), notice: "Tag successfully removed from all cards."
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :share)
  end

end
