class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_admin_user!

  def access_denied(error)
    redirect_to root_url, alert: error.message
  end
end
