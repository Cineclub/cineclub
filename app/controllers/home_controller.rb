class HomeController < ApplicationController
  def show
    if signed_in?
      render 'dashboard'
    else
      render 'home'
    end
  end
end
