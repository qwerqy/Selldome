class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_time , uniqueness: { scope: :user,
    message: "Date is taken" }
  validates :end_time , uniqueness: { scope: :user,
    message: "Date is taken" }
  validates :listing_id , uniqueness: { scope: :user,
    message: "You can't reserve a Home twice!" }


    def days
      "#{self.end_time.day - self.start_time.day} days"
    end
end
