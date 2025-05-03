class AddDeviseToAdminUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :admin_users, bulk: true do |t|
      # Add Devise columns
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end

    # Add indexes for Devise columns
    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end
end
