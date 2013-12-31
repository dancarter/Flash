class HomeController < ApplicationController

  def home
    if current_user.nil?
     render :action => 'welcome'
    else
      @cards = current_user.cards
      @tags = current_user.tags
    end
  end

  def welcome
  end

end
