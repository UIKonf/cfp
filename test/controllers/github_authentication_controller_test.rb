require 'test_helper'

class GithubAuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get logout" do
    get github_authentication_logout_url
    assert_response :redirect
  end
end
