class Rescue < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :breed

  enum status: { open: 0, taken: 1, resolved: 2 }
  enum size: { small: 0, medium: 1, large: 2 }

  has_one_attached :image

  def convert_to_animal
    return unless resolved? && shelter.present?

    Animal.create!(
      name: "Rescue #{self.id}",
      age: 1,
      breed: self.breed,
      shelter: self.shelter,
      adoption_status: :available,
    )
  end

  def self.ransackable_associations(auth_object = nil)
    ["shelter", "user", "category", "breed"]  # ← include category and breed
  end

  def self.ransackable_attributes(auth_object = nil)
    [
      "created_at", "description", "id", "image", "location",
      "shelter_id", "status", "updated_at", "user_id", "category_id", "breed_id", "size"
    ]
  end
end
