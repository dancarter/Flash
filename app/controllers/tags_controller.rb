class TagsController < AuthenticatedController

  def index
    @tags = current_user.tags
  end

  def show
    @tag = current_user.tags.find(params[:id])
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
      redirect_to new_tag_path, notice: 'Tag was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @tag = current_user.tags.build(tag_params)

    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    current_user.tags.find(params[:id]).destroy
    redirect_to tags_path, notice: 'Tag was successfully deleted.'
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
