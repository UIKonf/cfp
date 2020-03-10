require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    OmniAuth.config.test_mode = true
  end

  test 'successful login followed by logout' do
    OmniAuth.config.add_mock(:github, uid: @user.github_uid)

    get login_path
    assert_template 'github_authentication/new'

    post '/auth/github'
    assert_redirected_to '/auth/github/callback'
    follow_redirect!
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'welcome/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test 'unsuccessful login' do
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    get login_path
    assert_template 'github_authentication/new'

    post '/auth/github'
    assert_redirected_to '/auth/github/callback'
    follow_redirect!
    assert_redirected_to '/auth/failure?message=invalid_credentials&strategy=github'
    follow_redirect!
    assert_not is_logged_in?
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'github_authentication/new'
    assert_not flash.empty?
  end

  test 'cannot log in if blocked' do
    OmniAuth.config.add_mock(:github, uid: @user.github_uid)
    @user.block!('bad actor')

    get login_path
    assert_template 'github_authentication/new'

    post '/auth/github'
    assert_redirected_to '/auth/github/callback'
    follow_redirect!
    assert_not is_logged_in?
    assert_redirected_to root_url
  end

  test 'gets logged out if blocked' do
    OmniAuth.config.add_mock(:github, uid: @user.github_uid)

    get login_path
    assert_template 'github_authentication/new'

    post '/auth/github'
    assert_redirected_to '/auth/github/callback'
    follow_redirect!
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!

    @user.block!('bad actor')

    get '/'
    assert_not is_logged_in?
  end
end
