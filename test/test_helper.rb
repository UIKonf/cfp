ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

end

class ActionDispatch::IntegrationTest
  def log_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, uid: user.github_uid)
    post '/auth/github'
    follow_redirect!
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
  end

  def assert_authenticated_only
    assert_redirected_to login_url
  end
end
