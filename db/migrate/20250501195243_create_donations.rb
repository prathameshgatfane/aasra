class CreateDonations < ActiveRecord::Migration[7.2]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.string :frequency
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.boolean :dedicated

      t.timestamps
    end
  end
end
