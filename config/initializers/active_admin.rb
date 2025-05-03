ActiveAdmin.setup do |config|
  # == Site Title
  # Set the title that is displayed on the main layout for each of the active admin pages.
  config.site_title = "Aasra"

  # Set the link URL for the title. For example, to take users to your main site. Defaults to no link.
  # config.site_title_link = "/"

  # Set an optional image to be displayed for the header instead of a string (overrides :site_title)
  # config.site_title_image = "logo.png"

  # == Authentication Method
  # Set the method used for user authentication.
  config.authentication_method = :authenticate_admin_user!

  # == Current User Method
  # Set the method used for finding the current user.
  config.current_user_method = :current_admin_user

  # == Logging Out
  # Set the path and method for the logout link.
  config.logout_link_path = :destroy_admin_user_session_path

  # == Admin Comments
  # Disable the comments feature in Active Admin.
  config.comments = false

  # == Register Custom Stylesheet
  # Register custom stylesheets to be used in Active Admin.
  config.register_stylesheet 'active_admin.css'

  # == Batch Actions
  # Enable batch actions.
  config.batch_actions = true

  # == Filter Attributes
  # Exclude sensitive model attributes from being displayed.
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  # == Localization of Date/Time Format
  # Set the date/time format for the application.
  config.localize_format = :long

  # == Root Path
  # Define the root action for Active Admin.
  config.root_to = 'dashboard#index'

  # == Menu System
  # Customize the Active Admin navigation menu.
  # config.namespace :admin do |admin|
  #   admin.build_menu :default do |menu|
  #     menu.add label: "My Great Website", url: "http://www.mygreatwebsite.com", html_options: { target: "_blank" }
  #   end
  # end

  # == Pagination
  # Control the number of items per page.
  # config.default_per_page = 30

  # == Filters
  # Enable or disable filters for resources.
  config.filters = true

  # == Head
  # Add custom content to the head section.
  # config.head = ''.html_safe

  # == Footer
  # Customize the footer content.
  # config.footer = 'my custom footer text'

  # == Webpacker
  # Use Webpacker for asset management (optional).
  # config.use_webpacker = true
end
