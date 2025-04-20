class AdoptionRequest < ApplicationRecord
  belongs_to :user
  belongs_to :animal

  enum status: { requested: 0, adopted: 1 }
  # enum size: { small: 0, medium: 1, large: 2 }

  def self.ransackable_associations(auth_object = nil)
    ["animal", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["animal_id", "created_at", "id", "message", "status", "updated_at", "user_id"]
  end
end
