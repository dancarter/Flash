class TagsController < AuthenticatedController

  def index
    @tags = current_user.tags.all
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
     @tag = Tag.new(tag_params)
     @tag.user_id = current_user.id

    if @tag.save
      redirect_to @tag, notice: 'Tag was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: 'Tag was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
