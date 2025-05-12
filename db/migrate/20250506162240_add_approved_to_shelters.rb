class AddApprovedToShelters < ActiveRecord::Migration[7.2]
  def change
    add_column :shelters, :approved, :boolean
  end
end
