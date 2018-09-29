class ReservationsController < ApplicationController

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @listing = Listing.find(params[:listing_id])
    session[:reservation]
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.listing_id = @listing.id
    if @reservation.save
      flash[:success] = "You have placed a booking!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @reservation.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end


  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def test
    render template: 'reservations/review_booking'
  end

  def review_booking
    @reservation = Reservation.new(reservation_params)
    @listing = Listing.find(params[:listing_id])
    @reservation.user_id = current_user.id
    @reservation.listing_id = @listing.id
    @reservation.paid = false
    if @reservation.save
      respond_to do |format|
        format.html
      end
    else
      flash[:danger] = @reservation.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def booked_dates
    @listing = Listing.find(params[:listing_id])

    start_time = @listing.reservations.each_with_object([]) do |object, array|
      array << object.start_time
    end

    end_time = @listing.reservations.each_with_object([]) do |object, array|
      array << object.end_time
    end

    render :json => {start_time: start_time, end_time: end_time}

  end

  def construction
    @listing = Listing.find(7)
    @reservation = Reservation.find(1)
    render template: "reservations/review_booking_construction"
  end
  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:listing_id, :user_id, :start_time, :end_time, :guest_number, :total_bill, :paid)
    end
end
