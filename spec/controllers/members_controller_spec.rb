require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  describe 'GET #index' do
    it 'responds succesfully' do
      get :index, format: :csv
      expect(response).to be_success
    end

    it "assigns @members" do
      member = create :member

      get :index, format: :csv

      expect(assigns(:members)).to eq([member])
    end
  end

  describe 'GET #show' do
    let!(:member) { create :member }

    it 'responds succesfully' do
      get :show, id: member.to_param
      expect(response).to be_success
    end

    it "assigns @member" do
      get :show, id: member.to_param
      expect(assigns(:member)).to eq(member)
    end
  end

  describe 'PATCH #update' do
    let!('member') { create :member }

    def update_member(data: nil)
      unless data
        data = {
          first_name: build(:member).first_name
        }
      end

      patch :update, id: member.id, member: data, format: :json
    end

    it 'responds succesfully' do
      update_member
      expect(response).to have_http_status :ok
    end

    it 'can add devices' do
      devices = build_list :devices_device, 2
      data = {
        devices_attributes: [
          {
            mac_address: devices[0].mac_address,
            type_id: devices[0].type_id
          },
          {
            mac_address: devices[1].mac_address,
            type_id: devices[1].type_id
          }
        ]
      }

      expect { update_member(data: data)}.to change(member.devices, :count).by 2
    end
  end

end
