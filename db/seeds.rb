# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.delete_all
User.delete_all
Rent.delete_all

owner1 = User.create!(email: "stephane@wagon.com", password: "gdutosma")
owner2 = User.create!(email: "maxence@wagon.com", password: "gdutosma")
renter1 = User.create!(email: "romain@wagon.com", password: "gdutosma")
renter2 = User.create!(email: "cedric@wagon.com", password: "gdutosma")
rent1 = Rent.create!(start_date: "23/11/2016", end_date: "25/12/2016")
rent2 = Rent.create!(start_date: "01/01/2017", end_date: "01/02/2016")

owners = [owner1, owner2]
renters = [renter1, renter2]
users = owners + renters
rents = [rent1, rent2]

users.each do |user|
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
end

rents.each do |rent|
  rent.user = renters.sample
end

product1 = Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, category: Product::CATEGORY.sample )
product1.user = owner1
product1.save!
rent1.product = product1
rent1.save!

product2 = Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, category: Product::CATEGORY.sample )
product2.user = owner1
product2.save!
rent2.product = product2
rent2.save!

product3 = Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, category: Product::CATEGORY.sample )
product3.user = owner2
product3.save!
rent1.product = product1
rent1.save!

product3 = Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, category: Product::CATEGORY.sample )
product3.user = owner2
product3.save!
rent2.product = product1
rent2.save!
