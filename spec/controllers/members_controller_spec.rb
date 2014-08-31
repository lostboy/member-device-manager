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
end
