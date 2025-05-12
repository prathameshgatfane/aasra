class Shelter < ApplicationRecord
  has_many :animals
  has_one_attached :image
  belongs_to :user  # A shelter belongs to a user

  # Auto-geocode from address
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Prevent login unless approved (used only if Shelter logs in via Devise — optional)
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  # Ransack config
  def self.ransackable_attributes(auth_object = nil)
    ["address", "capacity", "created_at", "id", "name", "phone", "updated_at", "user_id", "approved"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "animals", "image_attachment", "image_blob"]
  end

  # Default to not approved
  after_initialize do
    self.approved = false if self.new_record? && self.approved.nil?
  end
end
