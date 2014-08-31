class Devices::TypesController < ApplicationController
  respond_to :json

  def index
    @types = Devices::Type.all
    respond_with @types
  end

end
