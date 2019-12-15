class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_mode
  before_action :correct_user, only: [:show]

  def show
  end

  private

  def check_mode
    check_mode_for_object(:user)
  end

  def correct_user
    @user = User.includes(:proposals).find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
