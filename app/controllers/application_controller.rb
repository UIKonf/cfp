class ApplicationController < ActionController::Base
  include GithubAuthenticationHelper

  def authenticate_user!
    unless logged_in?
      flash[:warning] = 'You need to log in to see this.'
      redirect_to login_url
    end
  end
end
