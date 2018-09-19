class Listing < ApplicationRecord
  belongs_to :user
  acts_as_taggable

  def self.place_type_string(data)
    if  data == 1
      "Apartment"
    elsif  data == 2
      "House"
    elsif  data == 3
      "Secondary Unit"
    elsif  data == 4
      "Unique Space"
    elsif data == 5
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

  def self.verified?(data)
    if data == true
      "Yes"
    elsif data == false
      "No"
    end
  end

  def country_name
     full_country = ISO3166::Country[country]
     full_country.translations[I18n.locale.to_s] || full_country.name
   end
   
end
