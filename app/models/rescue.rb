class Rescue < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :breed

  enum status: { open: 0, taken: 1, resolved: 2 }
  enum size: { small: 0, medium: 1, large: 2 }

  has_one_attached :image

  # Convert resolved rescue to Animal
  def convert_to_animal
    return unless resolved? && shelter.present?
  
    # Customize based on rescue's data (e.g., use location or description to auto-assign name or breed)
    Animal.create!(
      name: "Rescue #{self.id}", # or extract name from description if available
      age: 1,  # Default or derive from location info
      breed: self.breed,  # Optionally, set breed if rescue had breed info
      shelter: self.shelter,
      adoption_status: :available,
    )
  end

  def self.ransackable_associations(auth_object = nil)
    ["shelter", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "image", "location", "shelter_id", "status", "updated_at", "user_id"]
  end
end