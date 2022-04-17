require "test_helper"

class MakersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get makers_new_url
    assert_response :success
  end
end
