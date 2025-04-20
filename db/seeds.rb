# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
["adopter", "rescuer", "volunteer", "donor", "admin"].each do |role|
    Role.find_or_create_by(name: role)
end

['Dog', 'Cat', 'Rabbit', 'Bird', 'Cow'].each do |category|
    Category.create(name: category)
end

dog_breeds = [
    "Labrador Retriever",
    "German Shepherd",
    "Golden Retriever",
    "Bulldog",
    "Poodle",
    "Beagle",
    "Rottweiler",
    "Yorkshire Terrier",
    "Boxer",
    "Dachshund",
    "Siberian Husky",
    "Great Dane",
    "Doberman Pinscher",
    "Australian Shepherd",
    "Shih Tzu",
    "Border Collie",
    "Cocker Spaniel",
    "Pomeranian",
    "Chihuahua",
    "French Bulldog"
  ]

dog_breeds.each do |breed|
    category = Category.find_by_name('Dog')
    Breed.create(category_id: category.id, name: breed)
end

cat_breeds = [
    "Persian",
    "Maine Coon",
    "Siamese",
    "Ragdoll",
    "British Shorthair",
    "Sphynx",
    "Bengal",
    "Scottish Fold",
    "Abyssinian",
    "Birman",
    "Oriental Shorthair",
    "Russian Blue",
    "Norwegian Forest",
    "American Shorthair",
    "Himalayan",
    "Devon Rex",
    "Savannah",
    "Exotic Shorthair",
    "Tonkinese",
    "Turkish Angora"
  ]

cat_breeds.each do |breed|
    category = Category.find_by_name('Cat')
    Breed.create(category_id: category.id, name: breed)
end

rabbit_breeds = [
  "Holland Lop",
  "Netherland Dwarf",
  "Mini Rex",
  "Lionhead",
  "Flemish Giant",
  "English Angora",
  "Mini Lop",
  "Dutch",
  "Rex",
  "Himalayan",
  "English Spot",
  "Harlequin",
  "Checkered Giant",
  "American Fuzzy Lop",
  "Silver Marten",
  "French Lop",
  "New Zealand White",
  "Polish",
  "Chinchilla",
  "Satin"
]

rabbit_breeds.each do |breed|
    category = Category.find_by_name('Rabbit')
    Breed.create(category_id: category.id, name: breed)
end


bird_breeds = [
  "Budgerigar (Budgie)",
  "Cockatiel",
  "African Grey Parrot",
  "Lovebird",
  "Canary",
  "Finch",
  "Macaw",
  "Cockatoo",
  "Parakeet",
  "Amazon Parrot",
  "Conure",
  "Eclectus",
  "Quaker Parrot (Monk Parakeet)",
  "Lorikeet",
  "Indian Ringneck Parakeet",
  "Pionus Parrot",
  "Senegal Parrot",
  "Green-Cheeked Conure",
  "Zebra Finch",
  "Society Finch"
]

bird_breeds.each do |breed|
    category = Category.find_by_name('Bird')
    Breed.create(category_id: category.id, name: breed)
end


cow_breeds = [
  "Holstein Friesian",
  "Jersey",
  "Gir",
  "Sahiwal",
  "Red Sindhi",
  "Ongole",
  "Tharparkar",
  "Kankrej",
  "Hariana",
  "Rathi",
  "Khillari",
  "Deoni",
  "Amrit Mahal",
  "Krishna Valley",
  "Nagori",
  "Malnad Gidda",
  "Brahman",
  "Nelore",
  "Dexter",
  "Hereford"
]

cow_breeds.each do |breed|
    category = Category.find_by_name('Cow')
    Breed.create(category_id: category.id, name: breed)
end

pet_shelter_names = [
  "Paws & Hearts Shelter",
  "Furry Haven",
  "Wagging Tails Rescue",
  "Whisker World",
  "Snuggle Paws Sanctuary",
  "Safe Paw Refuge",
  "The Paw Haven",
  "Second Chance Paws",
  "Rescue Roots",
  "Pawprints of Hope",
  "Pine Paws Rescue",
  "Loving Tails Shelter",
  "Sunshine Fur Home",
  "Forever Fields Sanctuary",
  "Maple Tail Manor",
  "The Bark Side",
  "Fur Real Friends",
  "Pawsh Life Rescue",
  "Meow & Woof Inn",
  "Rescue Rangers Den"
]

pet_shelter_names.each do |name|
  Shelter.create!(
    name: name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    capacity: 150
  )
end

category = Category.find_by_name('Dog')
breed = category.breeds.first
breed_id = breed.id
category_id = category.id
shelter_id = Shelter.first.id
Animal.create!([
  {
    name: "Max",
    age: 2,
    gender: :male,
    size: :large,
    adoption_status: :available,
    breed_id: breed_id,
    category_id: category_id,  
    shelter_id: shelter_id,
    tags: ["Friendly", "Energetic", "Loyal"]
  },
  {
    name: "Whiskers",
    age: 1,
    gender: :female,
    size: :small,
    adoption_status: :available,
    breed_id: breed_id,
    category_id: category_id,  
    shelter_id: shelter_id,
    tags: ["Friendly", "Energetic", "Loyal"]
  },
  {
    name: "Bubbles",
    age: 0,
    gender: :female,
    size: :small,
    adoption_status: :pending,
    breed_id: breed_id,
    category_id: category_id,  
    shelter_id: shelter_id,
    tags: ["Friendly", "Energetic", "Loyal"]
  },
  {
    name: "Buddy",
    age: 4,
    gender: :male,
    size: :medium,
    adoption_status: :adopted,
    breed_id: breed_id,
    category_id: category_id,  
    shelter_id: shelter_id,
    tags: ["Friendly", "Energetic", "Loyal"]
  }
])