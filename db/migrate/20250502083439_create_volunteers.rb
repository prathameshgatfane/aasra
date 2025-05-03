class CreateVolunteers < ActiveRecord::Migration[7.2]
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :age
      t.string :preferred_position
      t.string :other_position
      t.string :availability
      t.text :experience
      t.text :motivation

      t.timestamps
    end
  end
end
