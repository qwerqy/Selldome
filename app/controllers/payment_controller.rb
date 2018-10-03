class PaymentController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    @client_token = Braintree::ClientToken.generate
    respond_to do |format|
      format.html
      format.js
    end
  end

  def checkout
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => @reservation.total_bill,
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      @reservation.update(paid: true)
      ReservationJob.perform_later(@reservation.user, @listing.user, @listing.id)

      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
