class AddImageToAnimals < ActiveRecord::Migration[7.2]
  def change
    add_column :animals, :image, :string
  end
end
