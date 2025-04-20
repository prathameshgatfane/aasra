class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "role_id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["role", "user"]
  end
end
