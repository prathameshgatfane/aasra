class AdminUser < ApplicationRecord
       devise :database_authenticatable, 
              :recoverable, :rememberable, :validatable, 
              :trackable # ← Include this if you're using tracking features
     
       attribute :role, :integer
     
       enum role: { admin: 0, shelter: 1 }
     
       def shelter?
         role == "shelter"
       end
     
       # Ransack allowed attributes
       def self.ransackable_attributes(auth_object = nil)
         %w[
           id email created_at updated_at
           remember_created_at reset_password_token reset_password_sent_at
           sign_in_count current_sign_in_at last_sign_in_at
         ]
       end
     
       def self.ransackable_associations(auth_object = nil)
         []
       end
     end
     