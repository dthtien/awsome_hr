module AuthenticationHelper
  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.includes(:employees).find_by(id: user_id)
    end
  end

  def logged_in?
    current_user.is_a? User
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or(default, options = {})
    redirecting_url = session[:forwarding_url] || default
    redirect_to(redirecting_url, options)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
