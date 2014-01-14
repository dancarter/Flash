class PagesController < ApplicationController

  def home
    if !user_signed_in?
     render :action => 'welcome'
    else
      @cards = current_user.cards
      @tags = current_user.tags
    end
  end

  def welcome
  end

  def review
  end

  def share
    @q = Tag.all.where( share: true ).search(params[:q])
    @tags = @q.result(distinct: true)
  end

  def search
    share
    render :share
  end

  def sharetag
    @tag = Tag.find(params[:tag_id])
  end

  def copy
    tag = Tag.find(params[:tag_id])
    tag.share = false
    Copier.copy_tag_to(tag, current_user)
    redirect_to action: 'share', notice: "Tag successfully copied."
  end

end
