class Shelter < ApplicationRecord
  has_many :animals
  has_one_attached :image
  belongs_to :user  # A shelter belongs to a user
  def self.ransackable_attributes(auth_object = nil)
    ["address", "capacity", "created_at", "id", "name", "phone", "updated_at"]
  end

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
