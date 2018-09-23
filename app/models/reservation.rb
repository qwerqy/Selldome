class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_time , uniqueness: { scope: :user,
    message: "Date is taken" }
  validates :end_time , uniqueness: { scope: :user,
    message: "Date is taken" }

end
