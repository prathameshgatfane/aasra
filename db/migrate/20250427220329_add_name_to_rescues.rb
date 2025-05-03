class AddNameToRescues < ActiveRecord::Migration[7.2]
  def change
    add_column :rescues, :name, :string
  end
end
