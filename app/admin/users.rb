ActiveAdmin.register User do
  # Permit required params
  permit_params :email, :full_name, :phone_number, :address, :approved, role_ids: []

  # Filters
  filter :email
  filter :full_name
  filter :created_at
  filter :roles
  filter :approved

  # Index view
  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column("Roles") { |user| user.roles.map(&:name).join(", ") }
    column :approved
    column :created_at

    actions defaults: true do |user|
      if user.is_shelter? && !user.approved?
        span do
          link_to "Approve Shelter", approve_admin_user_path(user), method: :put, class: "button green"
        end
        span do
          link_to "Reject Shelter", reject_admin_user_path(user), method: :delete, data: { confirm: "Are you sure?" }, class: "button red"
        end
      end
    end
  end

  # Show view
  show do
    attributes_table do
      row :id
      row :email
      row :full_name
      row :phone_number
      row :address
      row("Roles") { |user| user.roles.map(&:name).join(", ") }
      row :approved
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  # Form for creating/editing users
  form do |f|
    f.inputs do
      f.input :email
      f.input :full_name
      f.input :phone_number
      f.input :address
      f.input :roles, as: :check_boxes, collection: Role.all
      f.input :approved, hint: "Check this only if you're approving a shelter manually"
    end
    f.actions
  end

  # Approve Shelter Action
  member_action :approve, method: :put do
    resource.update(approved: true)
    redirect_to admin_users_path, notice: "Shelter approved successfully!"
  end

  # Reject Shelter Action
  member_action :reject, method: :delete do
    resource.destroy
    redirect_to admin_users_path, alert: "Shelter account rejected and deleted."
  end
end
