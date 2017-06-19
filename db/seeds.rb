# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# rules = Rule.create([{ name: "Pet's not allwoed" }, { name: 'Inside someking not allowed' }, {name: "Drinking allowed"}])
# amenities = Amenity.create([{ name: "TV" }, { name: 'Wifi' }, {name: "Parking"}])
  Admin.create(:email => 'sathi@gmail.com', :password => '12345678', :password_confirmation => '12345678')
