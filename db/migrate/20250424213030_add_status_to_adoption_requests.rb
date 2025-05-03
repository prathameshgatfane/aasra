class AddStatusToAdoptionRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :adoption_requests, :status, :integer
  end
end
