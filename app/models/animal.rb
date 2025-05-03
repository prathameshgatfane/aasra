class Animal < ApplicationRecord
  belongs_to :breed
  belongs_to :category
  belongs_to :shelter

  enum gender: { male: 0, female: 1 }
  enum size: { small: 0, medium: 1, large: 2, extra_large: 3 }
  enum adoption_status: { available: 0, adopted: 1, pending: 2 }
  enum age: { baby: 0, young: 1, adult: 2, senior: 3 } # Adding age enum for filtering

  # Ensure that the tags default to an empty array if not set
  before_validation :set_default_tags

  # Define the attributes that can be filtered via Ransack
  def self.ransackable_associations(auth_object = nil)
    ["breed", "shelter"]
  end

  def self.ransackable_attributes(auth_object = nil)
    # Keep the attributes you want to filter by
    ["adoption_status", "age", "breed_id", "created_at", "gender", "id", "name", "size", "updated_at"]
  end

  private

  def set_default_tags
    self.tags ||= []
  end
end
