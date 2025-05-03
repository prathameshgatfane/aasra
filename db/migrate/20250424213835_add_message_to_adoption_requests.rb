class AddMessageToAdoptionRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :adoption_requests, :message, :text
  end
end
