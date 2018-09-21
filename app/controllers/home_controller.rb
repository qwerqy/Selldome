class HomeController < ApplicationController
  before_action :require_login

  def index
  end

  def load_content
    respond_to do |format|
      format.html
    end
  end
end
