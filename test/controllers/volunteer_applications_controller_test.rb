require "test_helper"

class VolunteerApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get volunteer_applications_create_url
    assert_response :success
  end
end
