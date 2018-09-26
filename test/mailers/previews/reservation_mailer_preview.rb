# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def booking_email
    @reservation = Reservation.find(19)
    @listing = Listing.find(41)
    ReservationMailer.booking_email(@reservation.user, @listing.user, @listing.id)
  end
end
