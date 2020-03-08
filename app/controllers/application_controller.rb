class ApplicationController < ActionController::Base
  include AuthenticationHelper
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if logged_in?

    store_location
    redirect_to new_authentication_path, alert: 'Please login to continue'
  end

  def unauthenticate_user!
    return unless logged_in?

    redirect_to root_path, alert: 'Your account is already logged in'
  end
end
