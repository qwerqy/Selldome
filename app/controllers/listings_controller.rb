class ListingsController < ApplicationController
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
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update.attributes(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :location, :price, :description, :size, :user_id, :tag_list)
  end
end
