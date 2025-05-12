class AddDeviseToAdminUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :admin_users, bulk: true do |t|
      # Skip these if they already exist in the schema:
      # t.string :encrypted_password, null: false, default: ""
      # t.string :reset_password_token
      # t.datetime :reset_password_sent_at
      # t.datetime :remember_created_at

      # Optional Devise modules — only add if using them:
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Uncomment if using Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email

      # Uncomment if using Lockable
      # t.integer  :failed_attempts, default: 0, null: false
      # t.string   :unlock_token
      # t.datetime :locked_at
    end

    # Indexes (only add if not already present)
    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end
end
