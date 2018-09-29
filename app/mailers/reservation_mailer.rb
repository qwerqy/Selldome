class ReservationMailer < ApplicationMailer
  default from: 'aminrealestate87@gmail.com'

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation_id = reservation_id
    @url = 'http://selldome.com/home'
    content_type "multipart/alternative"

    part content_type: "text/html",
      body: render_message("booking_email", email: @host.email)

    part "text/plain" do |p|
      p.body = render_message("booking_email_text", email: @host.email)
      p.transfer_encoding = 'base64'
    end
    mail(to: @host.email, subject: 'You have a reservation!')
  end
end
