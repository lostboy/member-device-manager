class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_admin_user!

  def access_denied(error)
    redirect_to root_url, alert: error.message
  end

  # Configure paper_trail's function to retrieve user info
  def user_for_paper_trail
    current_admin_user.try(:id)
  end
end
