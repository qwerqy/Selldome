class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  delegate :url, to: :avatar, prefix: true
  require 'carrierwave/orm/activerecord'
  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :search_by_full_name, :against => [:first_name, :last_name],
  using: {
    tsearch: {
      prefix: true
    }
  }


  validates :password, presence: true, length: { minimum: 8, too_short: "Your password is too short!" }, :if => :password

 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     first_name: auth_hash["info"]["first_name"],
     last_name: auth_hash["info"]["first_name"],
     birthday: auth_hash["info"]["birthday"],
     email: auth_hash["info"]["email"],
     phone: auth_hash["info"]["phone"],
     password: SecureRandom.hex(10)
   )
   user.authentications << authentication
   return user
 end

 # grab google to access google for user data
 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end

 def name
   "#{self.first_name} #{self.last_name}"
 end

 def country_name
    full_country = ISO3166::Country[country]
    full_country.translations[I18n.locale.to_s] || full_country.name
  end

  def update_password(new_password, confirm_password)
    if new_password == confirm_password
      self.update(password: new_password)
    end
  end
end
