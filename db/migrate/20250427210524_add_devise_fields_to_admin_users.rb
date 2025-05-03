class AddDeviseFieldsToAdminUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :admin_users, bulk: true do |t|
      # Only add columns if they do not already exist
      unless column_exists?(:admin_users, :email)
        t.string :email, null: false, default: ""
      end

      unless column_exists?(:admin_users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      unless column_exists?(:admin_users, :reset_password_token)
        t.string :reset_password_token
      end

      unless column_exists?(:admin_users, :reset_password_sent_at)
        t.datetime :reset_password_sent_at
      end

      unless column_exists?(:admin_users, :remember_created_at)
        t.datetime :remember_created_at
      end
    end

    # Add indexes for Devise columns if they don't already exist
    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end
end
