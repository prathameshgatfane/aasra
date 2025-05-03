require "test_helper"

class FostersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fosters_index_url
    assert_response :success
  end
end
