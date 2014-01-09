class TagsController < AuthenticatedController

  def index
    @tags = current_user.tags
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
      msg = ''
      @tag.errors.messages.each do |error|
        msg << "#{error[0].to_s.capitalize} #{error[1][0]}. "
      end
      redirect_to tags_path, notice: "#{msg}Creation failed."
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])

    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      msg = ''
      @tag.errors.messages.each do |error|
        msg << "#{error[0].to_s.capitalize} #{error[1][0]}. "
      end
      redirect_to tags_path, notice: "#{msg}Update failed."
    end
  end

  def destroy
    current_user.tags.find(params[:id]).destroy
    redirect_to tags_path, notice: 'Tag was successfully deleted.'
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :share)
  end

end
