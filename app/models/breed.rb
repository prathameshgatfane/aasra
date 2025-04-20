class Breed < ApplicationRecord
  belongs_to :category
  has_many :animals

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["animals", "category"]
  end
end
