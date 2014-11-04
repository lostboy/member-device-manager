class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def access_denied(error)
    redirect_to root_url, alert: error.message
  end

  # Configure paper_trail's function to retrieve user info
  def user_for_paper_trail
    current_admin_user.try(:id)
  end
end
