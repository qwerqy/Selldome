class User < ApplicationRecord
  include Clearance::User
  mount_uploader :avatar, AvatarUploader

  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy

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
end
