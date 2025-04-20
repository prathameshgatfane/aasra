class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :rescues
  has_many :adoption_requests

  after_create :assign_default_role


  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end

  def assign_default_role
    self.roles << Role.find_by(name: "adopter") if roles.empty?
  end

  def self.ransackable_associations(auth_object = nil)
    ["roles", "user_roles"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end