class AddUserIdToShelters < ActiveRecord::Migration[7.2]
  def change
    add_column :shelters, :user_id, :bigint
  end
end
