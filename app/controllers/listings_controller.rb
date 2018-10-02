class ListingsController < ApplicationController
  before_action :require_login
  def my_index
    @user = current_user
    render 'listings/index'
  end

  def new
    @listing = Listing.new
  end

  def show
    @listing = Listing.includes(:reviews, :reservations).find(params[:id])
    @review = @listing.reviews.build
    @reservations = Reservation.where(listing_id: params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @listing = current_user.listings.build(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to my_listings_path
    else
      flash[:danger] = @listing.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
      flash[:success] = "Listing successfully updated!"
      redirect_to listing_path(@listing.id)
    else
      flash[:danger] = "Update Failed!"
      redirect_back(fallback_location: root_path)
    end
  end

  def upload_photos
    new_photos = listing_params[:photos]
    @listing = Listing.find(params[:id])
    photos = @listing.photos
    photos += new_photos
    @listing.photos = photos
    if @listing.save
      flash[:success] = "Photo(s) uploaded!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Error Occured"
      redirect_back(fallback_location: root_path)
    end
  end

  def show_upload
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def remove_photo
    @listing = Listing.find(params[:id])
    @listing.remove_image_at_index(params[:index].to_i)
    if @listing.save
      flash[:success] = "Photo removed"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Error Occured"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to my_listings_path
  end

  def view_photos
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.js
    end
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
      {photos: []},
      :instant_booking,
      review_attributes: [:id, :rating, :comment, :user_id]
    )
  end
end
