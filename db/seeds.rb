# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

old_products_count = Product.count
categories = Category.all
tags = Tag.all

num_to_add = [0, (50 - Product.count)].max
num_to_add.times do
  product = Product.create(name: Faker::Hipster.words(2).join(' '), price: rand(4)+1, tag_list: tags.sample, category_id: categories.sample)
end

puts "Added #{num_to_add} Products to the #{old_products_count} Products that were already there."
