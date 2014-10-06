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

  describe '#manage_ip?' do
    context 'belongs to hsv1-mem' do
      let(:type) { create :devices_type, hotspot: 'hsv1-mem' }
      let(:device) { build :device, type: type }

      it 'determines based on which hotspot it belongs to' do
        expect(device.manage_ip?).to be true
      end
    end

    context 'belongs to hsv2-bam' do
      let(:type) { create :devices_type, hotspot: 'hsv2-bam' }
      let(:device) { build :device, type: type }

      it 'determines based on which hotspot it belongs to' do
        expect(device.manage_ip?).to be false
      end
    end
  end
end
