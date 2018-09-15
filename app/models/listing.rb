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
    elsif self.place_type == 6
      "Restaurant"
    elsif self.place_type == 7
      "Cafe"
    else
      "Select One"
    end
  end
end
