class ListingsController < ApplicationController
  before_action :require_login
  def index
    render template: 'listings/index'
  end

  def new
    @listing = Listing.new
    render template: 'listings/new'
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    # @listing.tag_list.add(listing_params[:location])
    # @listing.tag_list.add(listing_params[:property_type])
    if @listing.save
      redirect_to my_listings_path
    else
      render template: "listings/new"
    end
  end

  def edit
    @listing = Listing.find(params[:id])
    render template: 'listings/edit'
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
      redirect_to my_listings_path
    else
      render :edit
    end
  end

  private

  def listing_params
    params.require(:listing).permit(
      :name,
      :place_type,
      :property_type,
      :room_number,
      :bathroom_number,
      :guest_number,
      :country,
      :state,
      :city,
      :zipcode,
      :address,
      :price,
      :description,
      :user_id,
      :tag_list
    )
  end
end
