ActiveAdmin.register VolunteerApplication do
    permit_params :full_name, :email, :phone_number, :availability, :skills, :motivation
  
    index do
      selectable_column
      id_column
      column :full_name
      column :email
      column :phone_number
      column :availability
      column :skills
      column :motivation
      column :created_at
      actions
    end
  
    filter :full_name
    filter :email
    filter :created_at
  
    show do
      attributes_table do
        row :full_name
        row :email
        row :phone_number
        row :availability
        row :skills
        row :motivation
        row :created_at
      end
    end
  
    form do |f|
      f.inputs do
        f.input :full_name
        f.input :email
        f.input :phone_number
        f.input :availability
        f.input :skills
        f.input :motivation
      end
      f.actions
    end
  end
  