ActiveAdmin.register AdoptionRequest do
  permit_params :user_id, :animal_id, :message, :status

  # Filters for admin to search AdoptionRequests
  filter :user
  filter :animal
  filter :status
  filter :created_at

  # Index view for listing Adoption Requests
  index do
    selectable_column
    id_column
    column :user do |adoption_request|
      adoption_request.user.email
    end
    column :animal do |adoption_request|
      adoption_request.animal.name
    end
    column :status
    column :message
    column :created_at
    actions
  end

  # Form for creating/updating Adoption Requests
  form do |f|
    f.inputs "Adoption Request Details" do
      f.input :user, as: :select, collection: User.all.collect { |u| [u.email, u.id] }, include_blank: false
      f.input :animal, as: :select, collection: Animal.all.collect { |a| [a.name, a.id] }, include_blank: false
      f.input :status, as: :select, collection: ["pending", "approved", "rejected"], include_blank: false
      f.input :message
    end
    f.actions
  end
end
