class AddTagsToAnimals < ActiveRecord::Migration[7.2]
  def change
    add_column :animals, :tags, :json
  end
end
