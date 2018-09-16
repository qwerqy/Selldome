class DomeController < ApplicationController
  def index
    render template: 'dome/index'
  end

  def show
    @listing = Listing.order(created_at: :asc).page params[:page]
    render :index
  end
end
