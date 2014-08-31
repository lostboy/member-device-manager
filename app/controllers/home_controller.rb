class HomeController < ApplicationController
  include AngularBootstrapper

  respond_to :html, :json

  def dashboard
  end
end
