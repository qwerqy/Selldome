class DomeController < ApplicationController
  before_action :require_login
  def index
    @pagination = Listing.order(:created_at).page params[:page]
    @listings = PgSearch.multisearch(params[:search]).map do |m|
                  Listing.find(m.id)
                end
    respond_to do |format|
    format.html
    end
  end

  def show_all
    @all_listings = Listing.all
    @pagination = @all_listings.page params[:page]
    respond_to do |format|
      format.html { render 'dome/index' }
      format.js
    end
  end

  def show_place_type
    @place_type = Listing.where("place_type = ?", params[:place_type])
    @pagination = @place_type.page params[:page]
    respond_to do |format|
      format.html { render 'dome/index' }
      format.js
    end
  end

  def show_by_guests
    @guest_number = Listing.where("guest_number >= :one AND guest_number <= :two", {one: params[:no1], two: params[:no2]})
    @pagination = @guest_number.page params[:page]
    respond_to do |format|
      format.js
    end
  end

  def show_by_price
    @price = Listing.where("price >= :start AND price <= :end", {start: params[:no1], end: params[:no2]})
    @pagination = @price.page params[:page]
    respond_to do |format|
      format.html { render 'dome/index'}
      format.js
    end
  end
end
