class AddSizeAgeToRescues < ActiveRecord::Migration[7.2]
  def change
    add_column :rescues, :age, :float
    add_column :rescues, :size, :integer
  end
end
