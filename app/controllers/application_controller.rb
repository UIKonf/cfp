class ApplicationController < ActionController::Base
  include GithubAuthenticationHelper
  include ModesHelper

  before_action :check_if_blocked

  def authenticate_user!
    unless logged_in?
      store_location
      flash[:warning] = 'You need to log in to see this.'
      redirect_to login_url
    end
  end
end
