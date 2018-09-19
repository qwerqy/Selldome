class ListingsController < ApplicationController
  before_action :require_login
  def my_index
    @user = current_user
    render template: 'listings/index'
  end

  def new
    @listing = Listing.new
    render template: 'listings/new'
  end

  def show
    @listing = Listing.find(params[:id])
    render template: 'listings/profile'
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
      flash[:success] = "Listing successfully updated!"
      redirect_to listing_path(@listing.id)
    else
      flash[:danger] = "Update Failed!"
      render :edit
    end
  end

  def upload_photos
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to my_listings_path
  end

  def property_from_place_type
    place = params[:place_type]
    if place == '1'
      @property_type = ["Apartment", "Condominium", "Casa particular (Cuba)", "Loft", "Serviced Apartment"]
    elsif place == '2'
      @property_type = ["House", "Bungalow", "Cabin", "Casa particular (Cuba)", "Chalet", "Cottage", "Cycladic House", "Dammuso (Italy)", "Dome House", "Earth House", "Farmstay", "Houseboat", "Hut", "Lighthouse", "Pension (South Korea)", "Shepherd's Hut (UK, France)", "Tiny House", "Townhouse", "Trullo (Italy)", "Villa"]
    elsif place == '3'
      @property_type = ["Guesthouse","Guest Suite","Farmstay"]
    elsif place == '4'
      @property_type = ["Barn", "Boat", "Bus", "Camper/RV", "Campsite", "Castle", "Cave", "Dome House", "Earth House", "Farmstay", "Hut", "Igloo, Island", "Lighthouse", "Pension (South Korea)", "Plane", "Shepherd's Hut (UK, France)", "Tent", "Tinyhouse", "Tipi", "Train", "Treehouse", "Windmill", "Yurt"]
    elsif place == '5'
      @property_type = ["Boutique Hotel", "Aparthotel", "Heritage Hotel (India)", "Hostel", "Hotel", "Natural Lodge", "Resort", "Serviced Apartment"]
    end
    render json: {property_type: @property_type}
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
      :tag_list,
      :verified,
      {photos: []}
    )
  end
end
