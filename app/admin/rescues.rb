ActiveAdmin.register Rescue do
  permit_params :image, :location, :description, :status, :size, :user_id, :shelter_id, :category_id, :breed_id

  # Filters - only for attributes allowed in ransackable_attributes
  filter :status, as: :select, collection: Rescue.statuses.keys
  filter :size, as: :select, collection: Rescue.sizes.keys
  filter :location
  filter :description
  filter :user
  filter :shelter
  filter :category
  filter :breed
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :image do |rescue_obj|
      if rescue_obj.image.attached?
        image_tag url_for(rescue_obj.image), size: "50x50"
      end
    end
    column :location
    column :description
    column :status
    column :size
    column :user
    column :shelter
    column :category
    column :breed
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :image do |rescue_obj|
        if rescue_obj.image.attached?
          image_tag url_for(rescue_obj.image), size: "150x150"
        end
      end
      row :location
      row :description
      row :status
      row :size
      row :user
      row :shelter
      row :category
      row :breed
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :location
      f.input :description
      f.input :status, as: :select, collection: Rescue.statuses.keys
      f.input :size, as: :select, collection: Rescue.sizes.keys
      f.input :user
      f.input :shelter
      f.input :category
      f.input :breed
    end
    f.actions
  end
end
