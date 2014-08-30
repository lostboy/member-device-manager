class UsersController < ApplicationController

  respond_to :csv

  def index
    @users = User.all
    respond_with @users
  end

end
