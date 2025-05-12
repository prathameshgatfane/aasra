class VolunteerApplication < ApplicationRecord
    belongs_to :user
  
    validates :full_name, :email, :phone_number, :availability, :motivation, presence: true
  
    def self.ransackable_attributes(auth_object = nil)
      %w[id full_name email phone_number availability motivation skills created_at user_id]
    end
  end
  