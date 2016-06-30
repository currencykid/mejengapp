require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get leaderboard" do
    get :leaderboard
    assert_response :success
  end

end
