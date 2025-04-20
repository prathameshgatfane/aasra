class Role < ApplicationRecord
    has_many :user_roles
    has_many :users, through: :user_roles

    def self.ransackable_associations(auth_object = nil)
        ["user_roles", "users"]
      end

      def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "name", "updated_at"]
      end
end
