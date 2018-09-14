class WelcomeController < ApplicationController
  def index
    if signed_in?
      redirect_to '/home/index'
    end
  end
end
