class Shelter < ApplicationRecord
  has_many :animals
  has_one_attached :image
  def self.ransackable_attributes(auth_object = nil)
    ["address", "capacity", "created_at", "id", "name", "phone", "updated_at"]
  end
end
