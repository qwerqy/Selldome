class Review < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :user_id, presence: true
  validates :rating, presence: true

  validates :listing_id, uniqueness: { scope: :user,
    message: "User can only comment once" }
end
