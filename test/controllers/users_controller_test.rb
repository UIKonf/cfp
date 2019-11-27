require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test 'logged in user can see their profile' do
    log_in_as(@user)

    get user_path(@user)
    assert_response :success
  end

  test 'logged in user cannot see another profile' do
    log_in_as(@user)

    get user_path(@other_user)
    assert_redirected_to root_url
  end
end
