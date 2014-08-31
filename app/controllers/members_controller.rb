class MembersController < ApplicationController
  include AngularBootstrapper

  respond_to :html, :json, :csv

  def index
    @members = Member.all
    respond_with @members
  end

  def show
    @member = Member.find params[:id]
    respond_with @member
  end

end
