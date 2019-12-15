module GithubAuthenticationHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user && user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def check_if_blocked
    if current_user&.blocked
      log_out
      flash[:danger] = BLOCK_MSG
      redirect_to root_url
    end
  end

  BLOCK_MSG = "You've been blocked from the UIKonf Call for Proposals due to a violation of our code of conduct. If you feel like this happened in error, please contact us.".freeze
end
