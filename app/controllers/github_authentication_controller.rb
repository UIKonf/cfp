class GithubAuthenticationController < ApplicationController
  def callback
    auth_hash = request.env['omniauth.auth']
    @user = User.find_by_github_uid(auth_hash[:uid]) || User.create_with_omniauth(auth_hash)

    if @user
      log_in(@user)
      flash[:success] = 'Logged in successfully'
      redirect_to user_url(@user)
    else
      flash[:danger] = 'Ooops, something went wrong logging you in :/'
      redirect_to login_url
    end
  end

  def logout
    log_out
    flash[:success] = 'Logged out'
    redirect_to root_url
  end
end
