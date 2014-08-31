require 'rails_helper'

RSpec.describe Devices::TypesController, type: :controller do
  describe 'GET #index' do
    it 'responds succesfully' do
      get :index, format: :json
      expect(response).to be_success
    end

    it "assigns @types" do
      type = create :devices_type

      get :index, format: :json

      expect(assigns(:types)).to eq([type])
    end
  end
end
