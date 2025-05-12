class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :rescues
  has_many :adoption_requests
  has_many :volunteer_applications
  has_one :shelter

  accepts_nested_attributes_for :user_roles

  # Virtual attribute for selecting role in form
  attr_accessor :role_name

  before_save :check_role

  # === Role helpers ===
  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end

  def is_shelter?
    has_role?("shelter")
  end

  def is_rescuer?
    has_role?("rescuer")
  end

  # Automatically assign role if not already present
  def check_role
    if role_name.present? && !has_role?(role_name)
      self.roles << Role.find_by(name: role_name)
    elsif self.roles.empty?
      self.roles << Role.second # fallback default
    end
  end

  # === Login restriction based on approval ===
  def active_for_authentication?
    super && approved_to_login?
  end

  def inactive_message
    is_shelter? && !approved? ? :not_approved : super
  end

  private

  # Shelter login only if approved
  def approved_to_login?
    return true unless is_shelter? # Only shelter requires approval
    approved?
  end

  # === Ransack configuration ===
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id email full_name phone_number address approved
      created_at updated_at
      remember_created_at reset_password_token reset_password_sent_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      roles user_roles shelter rescues
      adoption_requests volunteer_applications
    ]
  end
end
