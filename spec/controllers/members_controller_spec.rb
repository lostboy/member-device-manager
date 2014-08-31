require 'rails_helper'

describe MembersController do
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
end
