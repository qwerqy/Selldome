class DomeController < ApplicationController
  def index
    @listing = Listing.order(:created_at).page params[:page]
    render template: 'dome/index'
  end
end
