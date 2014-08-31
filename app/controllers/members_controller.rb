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

  def update
    @member = Member.find params[:id]

    if @member.update_attributes! member_params
      head :ok
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  private
  def member_params
    params
      .require(:member)
      .permit(
        :first_name,
        :last_name,
        :email,
        devices_attributes: [:id, :name, :mac_address, :type_id, :_destroy],
      )
  end
end
