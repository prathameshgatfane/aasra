class CreateAnimals < ActiveRecord::Migration[7.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.integer :size
      t.integer :adoption_status
      t.references :breed, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :shelter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
