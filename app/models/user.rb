class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :rescues
  has_many :adoption_requests
  has_many :volunteer_applications  # ✅ Add this line
  has_one :shelter  # Association with shelter

  # Virtual attribute to capture role selection from form
  attr_accessor :role_name

  after_create :assign_selected_or_default_role

  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end

  def is_shelter?
    has_role?("shelter")
  end

  private

  def assign_selected_or_default_role
    if role_name.present?
      selected_role = Role.find_by(name: role_name)
      self.roles << selected_role if selected_role
    elsif roles.empty?
      self.roles << Role.find_by(name: "adopter")
    end
  end

  def self.ransackable_associations(auth_object = nil)
    ["roles", "user_roles"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
