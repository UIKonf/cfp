require 'test_helper'

class GithubAuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get logout" do
    delete logout_url
    assert_response :redirect
  end
end
