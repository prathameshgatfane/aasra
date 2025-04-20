class CreateRescues < ActiveRecord::Migration[7.2]
  def change
    create_table :rescues do |t|
      t.string :image
      t.string :location
      t.text :description
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
