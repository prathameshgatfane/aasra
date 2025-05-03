# app/admin/dashboard.rb
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Rescues" do
          ul do
            Rescue.order("created_at desc").limit(5).each do |rescued_animal|
              li "#{rescued_animal.name} - #{rescued_animal.status} (#{rescued_animal.created_at.strftime('%b %d, %Y')})"
            end
          end
          
        end
      end

      column do
        panel "Recent Adoption Requests" do
          ul do
            AdoptionRequest.order("created_at desc").limit(5).each do |adoption_request|
              li "#{adoption_request.message} - #{adoption_request.status} (#{adoption_request.created_at.strftime('%b %d, %Y')})"
            end
          end
        end
      end
    end
  end # content
end
