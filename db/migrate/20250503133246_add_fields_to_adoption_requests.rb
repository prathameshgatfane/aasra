class AddFieldsToAdoptionRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :adoption_requests, :housing_type, :string
    add_column :adoption_requests, :have_pets, :boolean
    add_column :adoption_requests, :experience, :text
    add_column :adoption_requests, :preferred_pet, :string
    add_column :adoption_requests, :full_name, :string
    add_column :adoption_requests, :email, :string
    add_column :adoption_requests, :phone_number, :string
    add_column :adoption_requests, :address, :text
  end
end
