class DomeController < ApplicationController
  before_action :require_login
  def index
    @listing = Listing.order(:created_at).page params[:page]
    render template: 'dome/index'
  end
end
