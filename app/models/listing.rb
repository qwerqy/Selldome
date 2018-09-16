class Listing < ApplicationRecord
  belongs_to :user
  acts_as_taggable

  def place_type_string
    if self.place_type == 1
      "Apartment"
    elsif self.place_type == 2
      "House"
    elsif self.place_type == 3
      "Secondary Unit"
    elsif self.place_type == 4
      "Unique Space"
    elsif self.place_type == 5
      "Boutique Hotel"
    else
      "Select One"
    end
  end

  def self.all_place_type
    all_place_type = ["Apartment", "House", "Secondary Unit", "Unique Space", "Boutique Hotel"]
  end

  def self.all_attr
    all_attr = ["Dates","Guests", "Home Type", "Price", "Instant Book", "More filters"]
  end
end
