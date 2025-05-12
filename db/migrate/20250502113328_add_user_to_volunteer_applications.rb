class AddUserToVolunteerApplications < ActiveRecord::Migration[7.2]
  def change
    add_reference :volunteer_applications, :user, null: false, foreign_key: true
  end
end
