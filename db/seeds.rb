# Admin Account
User.create(first_name: 'SuperAdmin', last_name: 'Amin', email: 'superadmin@selldome.com', gender: 1, country: 'MY', password: '123123', superadmin: true)

# Mod Account
User.create(first_name: 'Moderator', last_name: 'Amin', email: 'moderator@selldome.com', gender: 1, country: 'MY', password: '123123', moderator: true)

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
    user['country'] = Faker::Address.country_code
    user['birthday'] = Faker::Date.between(50.years.ago, Date.today)
    user['about_me'] = Faker::GreekPhilosophers.quote
    user['remote_avatar_url'] = Faker::LoremFlickr.image("300x300", ['people'])

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
    if listing['place_type'] == 1
      listing['property_type'] = ["Apartment", "Condominium", "Casa particular (Cuba)", "Loft", "Serviced Apartment"].sample
    elsif listing['place_type'] == 2
      listing['property_type'] = ["House", "Bungalow", "Cabin", "Cottage", "Cycladic House", "Dammuso (Italy)", "Dome House", "Earth House", "Farmstay", "Houseboat", "Hut", "Lighthouse", "Pension (South Korea)", "Shepherd's Hut (UK, France)", "Tiny House", "Townhouse", "Trullo (Italy)", "Villa"].sample
    elsif listing['place_type'] == 3
      listing['property_type'] = ["Guesthouse","Guest Suite","Farmstay"].sample
    elsif listing['place_type'] == 4
      listing['property_type'] = ["Barn", "Boat", "Bus", "Camper/RV", "Campsite", "Castle", "Cave", "Dome House", "Earth House", "Farmstay", "Hut", "Igloo, Island", "Lighthouse", "Pension (South Korea)", "Plane", "Shepherd's Hut (UK, France)", "Tent", "Tinyhouse", "Tipi", "Train", "Treehouse", "Windmill", "Yurt"].sample
    elsif listing['place_type'] == 5
      listing['property_type'] = ["Boutique Hotel", "Aparthotel", "Heritage Hotel (India)", "Hostel", "Hotel", "Natural Lodge", "Resort", "Serviced Apartment"].sample
    end
    listing['room_number'] = rand(1..10)
    listing['bathroom_number'] = rand(1..6)
    listing['guest_number'] = rand(1..10)

    listing['country'] = Faker::Address.country_code
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
