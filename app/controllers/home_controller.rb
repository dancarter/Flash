class HomeController < ApplicationController

  def home
    if current_user.nil?
     render :action => 'welcome'
    end
  end

  def welcome
  end

end
