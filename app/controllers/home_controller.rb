class HomeController < ApplicationController
  before_action :require_login

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def load_content
    respond_to do |format|
      format.html
    end
  end
end
