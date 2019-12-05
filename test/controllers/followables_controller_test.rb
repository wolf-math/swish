require 'test_helper'

class FollowablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get followables_index_url
    assert_response :success
  end

  test "should get update" do
    get followables_update_url
    assert_response :success
  end

  test "should get show" do
    get followables_show_url
    assert_response :success
  end

end
