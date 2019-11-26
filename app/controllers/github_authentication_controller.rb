class GithubAuthenticationController < ApplicationController
  def callback
    auth_hash = request.env['omniauth.auth']
    @user = User.find_by_github_uid(auth_hash[:uid]) || User.create_with_omniauth(auth_hash)

    if @user
      session[:user_id] = @user.id
      flash[:success] = 'Signed in successfully'
      redirect_to user_url(@user)
    else
      redirect_to login_url
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = 'Signed out'
    redirect_to root_url
  end
end
