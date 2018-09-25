class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_time , uniqueness: { scope: :user,
    message: "Date is taken" }
  validates :end_time , uniqueness: { scope: :user,
    message: "Date is taken" }
  validates :listing_id , uniqueness: { scope: :user,
    message: "You can't reserve a Home twice!" }
  validate :no_reservation_overlap

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
