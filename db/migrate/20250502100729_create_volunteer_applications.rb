class CreateVolunteerApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :volunteer_applications do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :interest_area
      t.text :message

      t.timestamps
    end
  end
end
