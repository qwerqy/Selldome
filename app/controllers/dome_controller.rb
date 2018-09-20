class DomeController < ApplicationController
  before_action :require_login
  def index
    @pagination = Listing.order(:created_at).page params[:page]
    respond_to do |format|
      format.html
    end
  end

  def show_all
    @pagination = Listing.order(:created_at).page params[:page]
    respond_to do |format|
      format.js
    end
  end

  def show_place_type
    @place_type = Listing.where("place_type = ?", params[:place_type])
    @pagination = Listing.where(place_type: params[:place_type]).page params[:page]
    respond_to do |format|
      format.js
    end
  end

  def show_by_guests
    @guest_number = Listing.where("guest_number >= :one AND guest_number <= :two", {one: params[:no1], two: params[:no2]})
    @pagination = Listing.where(guest_number: params[:no1]..params[:no2]).page params[:page]
    respond_to do |format|
      format.js
    end
  end
end
