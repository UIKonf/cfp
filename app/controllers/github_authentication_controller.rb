# frozen_string_literal: true

class GithubAuthenticationController < ApplicationController
  before_action :check_mode, only: %i[new callback failure]

  def callback
    auth_hash = request.env['omniauth.auth']
    @user = User.find_by_github_uid(auth_hash[:uid]) || User.create_with_omniauth(auth_hash)

    if @user&.blocked
      flash[:danger] = GithubAuthenticationHelper::BLOCK_MSG
      redirect_to root_url
    elsif @user
      log_in(@user)
      flash[:success] = 'Logged in successfully'
      redirect_to root_url
    else
      flash[:danger] = 'Ooops, something went wrong logging you in :/'
      redirect_to login_url
    end
  end

  def failure
    flash[:danger] = "Oops, something went wrong on GitHub's side: #{params[:message]}"
    redirect_to login_url
  end

  def logout
    log_out
    flash[:success] = 'Logged out'
    redirect_to root_url
  end

  private

  def check_mode
    unless can?(:log_in, :user)
      flash[:danger] = "You cannot log in in #{Cfp.mode.mode} mode"
      redirect_to root_url
    end
  end
end
