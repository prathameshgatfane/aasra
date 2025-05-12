require "test_helper"

class Shelters::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shelters_dashboard_index_url
    assert_response :success
  end
end
