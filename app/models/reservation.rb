class Reservation < ApplicationRecord
  attr_accessor :skip_validations
  belongs_to :listing
  belongs_to :user
  delegate :id, :avatar, :name, :first_name, :last_name, :birthday, :email, :phone, :country, :gender, :about_me, to: :user, prefix: true
  delegate :name, to: :listing, prefix: true
  
  validates :start_time , presence: true
  validates :end_time , presence: true
  validates :listing_id , uniqueness: { scope: :user,
    message: "You can't reserve a Home twice!" }
  validate :no_reservation_overlap, unless: :skip_validations

    scope :overlapping, ->(period_start, period_end) do
      where "((start_time <= ?) and (end_time >= ?))", period_end, period_start
    end

  def days
    "#{self.end_time.day - self.start_time.day} nights"
  end


  private

  def no_reservation_overlap
    if (Reservation.overlapping(start_time, end_time).any?)
       errors.add(:end_time, 'it overlaps another reservation')
    end
  end
end
