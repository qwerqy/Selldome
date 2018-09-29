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
    @listing = Listing.find(params[:id])
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
    remove_image_at_index(params[:index].to_i)
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
