require 'rails_helper'

describe UsersController do
  describe 'GET #index' do
    it 'responds succesfully' do
      get :index, format: :csv
      expect(response).to be_success
    end

    it "assigns @users" do
      user = create :user

      get :index, format: :csv

      expect(assigns(:users)).to eq([user])
    end
  end
end
