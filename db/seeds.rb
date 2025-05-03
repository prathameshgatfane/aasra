require 'faker'

# Clear existing data
User.destroy_all
Role.destroy_all
Category.destroy_all
Breed.destroy_all
Shelter.destroy_all
Animal.destroy_all

# Roles
roles = ["adopter", "rescuer", "volunteer", "donor", "admin"]
roles.each do |role|
  Role.find_or_create_by!(name: role)
end

# Admin user
admin_user = User.find_or_initialize_by(email: 'admin@example.com')
if admin_user.new_record?
  admin_user.password = 'admin123'
  admin_user.password_confirmation = 'admin123'
  admin_user.save!
end
admin_user.roles << Role.find_by(name: 'admin') unless admin_user.roles.exists?(name: 'admin')

# Create 20 random users with random roles (excluding admin)
20.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
  assigned_role = roles.reject { |r| r == 'admin' }.sample
  user.roles << Role.find_by(name: assigned_role)
end

# Categories and breeds
category_breeds = {
  "Dog" => ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog"],
  "Cat" => ["Persian", "Siamese", "Maine Coon", "Bengal"],
  "Rabbit" => ["Holland Lop", "Netherland Dwarf", "Mini Rex"],
  "Bird" => ["Budgerigar", "Cockatiel", "African Grey Parrot"],
  "Cow" => ["Gir", "Jersey", "Holstein Friesian"]
}

category_breeds.each do |category_name, breeds|
  category = Category.find_or_create_by!(name: category_name)
  breeds.each do |breed|
    Breed.find_or_create_by!(category_id: category.id, name: breed)
  end
end

# Shelters
shelter_names = [
  "Paws & Hearts Shelter", "Furry Haven", "Wagging Tails Rescue", "Whisker World", "Snuggle Paws Sanctuary",
  "Safe Paw Refuge", "The Paw Haven", "Second Chance Paws", "Rescue Roots", "Pawprints of Hope",
  "Pine Paws Rescue", "Loving Tails Shelter", "Sunshine Fur Home", "Forever Fields Sanctuary", "Maple Tail Manor",
  "The Bark Side", "Fur Real Friends", "Pawsh Life Rescue", "Meow & Woof Inn", "Rescue Rangers Den"
]

shelter_names.each do |name|
  Shelter.find_or_create_by!(
    name: name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    capacity: 150,
    user: admin_user
  )
end

# Sample Animals
category = Category.find_by_name('Dog')
breed = category.breeds.first
shelter = Shelter.first

Animal.create!([
  {
    name: "Max",
    age: :adult,
    gender: :male,
    size: :large,
    adoption_status: :available,
    breed_id: breed.id,
    category_id: category.id,
    shelter_id: shelter.id,
    tags: ["Friendly", "Energetic", "Loyal"]
  },
  {
    name: "Whiskers",
    age: :young,
    gender: :female,
    size: :small,
    adoption_status: :available,
    breed_id: breed.id,
    category_id: category.id,
    shelter_id: shelter.id,
    tags: ["Playful", "Cute", "Active"]
  }
])

puts "Geocoding shelters..."
Shelter.find_each do |shelter|
  shelter.geocode
  if shelter.latitude.nil? || shelter.longitude.nil?
    puts "Failed to geocode: #{shelter.name} (#{shelter.address})"
  else
    shelter.save!
    puts "Geocoded: #{shelter.name} => #{shelter.latitude}, #{shelter.longitude}"
  end
end
