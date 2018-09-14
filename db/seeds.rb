# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'Amin', last_name: 'Roslan', email: 'amnrsln@gmail.com', phone: '0123456789', password: 'amin123')

Listing.create(
  name: 'Studio Unit, M-City',
  location: 'M-City, Jalan Ampang, Kuala Lumpur',
  price: 1200,
  description: "Like a megapolis of people and trees rising up in the air,
  M City certainly makes an impression. Poised to be the next property hotspot,
  M City will set a new benchmark as the most iconic tower in the Ampang area.
  With parks, streams and sky bridges high up in the air,
  the most exciting garden city development in Kuala Lumpur creates an all-new natural living experience.
  Its location on the Embassy Row @ Jalan Ampang makes it particularly appealing to the thriving local and
  international community. And by being just 5km away from KLCC, you won’t be far away from the epicentre of
  Malaysia’s premier economic landmark.",
  size: '1200sqf'
)
