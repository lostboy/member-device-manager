require 'rails_helper'

describe Devices::Device do
  subject(:device) { build :device }

  describe 'is_valid?' do
    it 'should have a valid factory' do
      expect(build :device).to be_valid
    end

    it 'should require a mac address' do
      expect(build :device, mac_address: nil).not_to be_valid
    end

    it 'should require a correct mac address' do
      expect(build :device, mac_address: '0Z:00:2b:01:02:03').not_to be_valid
    end
  end
end
