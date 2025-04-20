class CreateAdoptionRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :adoption_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shelter, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true
      t.text :reason
      t.string :description

      t.timestamps
    end
  end
end
