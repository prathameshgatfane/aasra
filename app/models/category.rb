class Category < ApplicationRecord
    has_many :breeds

    def self.ransackable_associations(auth_object = nil)
        ["breeds"]
      end
      
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end    
end
