# Seed Users
user = {}
user['password'] = 'asdf'
# user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['gender'] = rand(1..2)
    user['phone'] = Faker::PhoneNumber.phone_number
    user['country'] = Faker::Address.country
    user['birthday'] = Faker::Date.between(50.years.ago, Date.today)

    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['name'] = Faker::App.name
    listing['place_type'] = rand(1..5)

    listing['room_number'] = rand(1..10)
    listing['bathroom_number'] = rand(1..6)
    listing['guest_number'] = rand(1..10)

    listing['country'] = Faker::Address.country
    listing['state'] = Faker::Address.state
    listing['city'] = Faker::Address.city
    listing['zipcode'] = Faker::Address.zip_code
    listing['address'] = Faker::Address.street_address

    listing['price'] = rand(80..500)
    listing['description'] = Faker::Hipster.sentence
    listing['tag_list'] = Faker::Hipster.words(4, true, true)

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
