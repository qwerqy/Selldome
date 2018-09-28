class ReservationMailer < ApplicationMailer
  default from: 'aminrealestate87@gmail.com'

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation_id = reservation_id
    @url = 'http://selldome.com/home'
    mail(to: @host.email, subject: 'You have a reservation!')
  end
end
