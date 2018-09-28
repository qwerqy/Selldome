class Listing < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :reviews
  has_many :reservations

  mount_uploaders :photos, PhotoUploader
  acts_as_taggable

  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :place_type, presence: true
  validates :property_type, presence: true

  multisearchable :against => [:name, :country, :state, :address, :city, :place_type, :property_type, :price, :tag_list]

  def self.search(search)
    if search
      name = Listing.where(name: search.titleize)
      country = Listing.where(country: search.upcase)
      state = Listing.where(state: search.titleize)
      city = Listing.where(city: search.titleize)
      address = Listing.where(address: search.titleize)
      property_type = Listing.where(property_type: search.titleize)
      place_type = Listing.where(place_type: Listing.string_to_place_type(search.titleize))
      {
        Names: name,
        Home: property_type,
        Place: place_type,
        Countries: country,
        States: state,
        Cities: city,
        Addresses: address
      }

    else
      Listing.all
    end
  end

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

  def self.string_to_place_type(data)
    if  data == "Apartment"
      return 1
    elsif  data == "House"
      return 2
    elsif  data == "Secondary Unit"
      return 3
    elsif  data == "Unique Space"
      return 4
    elsif data == "Boutique Hotel"
      return 5
    end
  end

  def self.all_place_type
    all_place_type = ["Apartment", "House", "Secondary Unit", "Unique Space", "Boutique Hotel"]
  end

  def self.all_title
    all_title = ["Look for more Homes","One does not stay for one night!","Who needs a house, when you selldome live in one!","Browse for More!"]
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

private

  def remove_image_at_index(index)
  remain_photos = @listing.photos
      if index == 0 && @listing.photos.size == 1
          @listing.remove_photos!
      else
          deleted_photo = remain_photos.delete_at(index)
          deleted_photo.try(:remove!)
          @listing.photos = remain_photos
      end
  end
end
