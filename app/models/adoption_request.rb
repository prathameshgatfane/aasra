class AdoptionRequest < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  belongs_to :shelter

  enum status: { requested: 0, accepted: 1, rejected: 2 }

  validates :housing_type, :experience, :preferred_pet, presence: true
  validates :have_pets, inclusion: { in: [true, false], message: "must be selected" }

  def self.ransackable_associations(auth_object = nil)
    ["animal", "user", "shelter"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["animal_id", "created_at", "id", "message", "status", "updated_at", "user_id", "housing_type", "have_pets", "experience", "preferred_pet", "shelter_id"]
  end
end
