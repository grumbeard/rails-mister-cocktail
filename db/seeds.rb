require 'json'
require 'open-uri'
require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying all cocktails / doses / ingredients...'
Cocktail.destroy_all

puts 'Creating some ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients_data = JSON.parse(ingredients_serialized)

ingredients_data['drinks'].each do |ingredient|
  new_ingredient = Ingredient.create(name: ingredient['strIngredient1'])
  puts new_ingredient.name
end

puts 'Creating some cocktails...'

10.times do
  cocktail_name = Faker::Company.bs.titleize
  puts "Creating a #{cocktail_name}"
  new_cocktail = Cocktail.new(name: cocktail_name)
  new_cocktail.save
  rand(2..5).times do
    puts 'Creating a dose...'
    dose_ingredient = Ingredient.all.sample
    dose_amount = rand(1..3)
    dose_description = "Add #{dose_amount} #{dose_ingredient.name}"
    new_dose = Dose.new(description: dose_description, cocktail_id: new_cocktail.id, ingredient_id: dose_ingredient.id)
    new_dose.save
    puts "Created #{new_dose.description}"
  end
end
