class HomeController < ApplicationController
    skip_before_action :authenticate_user_unless_admin!
  
    def index
    end
  end
  