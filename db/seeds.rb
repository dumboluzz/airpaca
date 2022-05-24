# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "-- clearing database --"
Booking.destroy_all
Alpaca.destroy_all
User.destroy_all

puts "-- adding default users --"
User.create(first_name: "Vincent", last_name: "Stuber", email: "vincent@stuber.com", password: "123456", password_confirmation: "123456")
User.create(first_name: "Sophie", last_name: "Sorin", email: "sophie@sorin.com", password: "123456", password_confirmation: "123456")
User.create(first_name: "Maria", last_name: "Pigazzi", email: "maria@pigazzi.com", password: "123456", password_confirmation: "123456")
User.create(first_name: "Finn", last_name: "Stürenburg", email: "finn@stuerenburg.com", password: "123456", password_confirmation: "123456")

puts "-- generating alpacas --"
10.times do
  a = Alpaca.new
  a.name = Faker::Name.unique.name
  a.nick_name = a.name
  a.age = rand(1..17)
  a.price_per_day = rand(25..75)
  a.height = rand(81..99)
  a.weight = rand(48..84)
  a.color = ["white", "gray", "brown", "black"].sample
  a.wool_type = ["Suri", "Huacaya"].sample
  a.owner = User.order(Arel.sql('RANDOM()')).first
  a.save
end

puts "-- generating bookings --"
20.times do
  b = Booking.new
  b.start_date = Date.today + rand(1..3)
  b.end_date = Date.today + rand(4..6)
  b.alpaca = Alpaca.order(Arel.sql('RANDOM()')).first
  b.full_price = b.alpaca.price_per_day * (b.end_date - b.start_date).to_i
  b.renter = User.order(Arel.sql('RANDOM()')).first
  b.status = ["pending", "accepted", "rejected"].sample
  b.save
end
