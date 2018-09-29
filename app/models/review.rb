class Review < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :rating, presence: true

  validates :listing_id, uniqueness: { scope: :user,
    message: "User can only comment once" }
end
