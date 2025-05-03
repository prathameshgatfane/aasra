class AdminUser < ApplicationRecord
       # Include default devise modules
       devise :database_authenticatable, 
              :recoverable, :rememberable, :validatable
     
       # Explicitly declare attribute type (required in Rails 7.2+)
       attribute :role, :integer
     
       # Role enum
       enum role: { admin: 0, shelter: 1 }
     
       # Define helper method for checking if user is a shelter
       def shelter?
         role == "shelter"
       end
     
       # Ransackable attributes
       def self.ransackable_attributes(auth_object = nil)
         ["created_at", "email", "encrypted_password", "id", "remember_created_at", 
          "reset_password_sent_at", "reset_password_token", "updated_at"]
       end
     end
     