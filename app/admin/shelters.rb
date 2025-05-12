ActiveAdmin.register Shelter do
  permit_params :name, :location, :description, :user_id, :image

  filter :name
  filter :location
  filter :description
  filter :user
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :location
    column :description
    column :user
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :location
      row :description
      row :user
      row :created_at
      row :updated_at
      row :image do |shelter|
        if shelter.image.attached?
          image_tag url_for(shelter.image), size: "150x150"
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :location
      f.input :description
      f.input :user
      f.input :image, as: :file
    end
    f.actions
  end
end
