require 'rails_helper'

describe Devices::Device do
  let!(:membership_level) { create :membership_level, network: '10.10.2.0/24' }
  let!(:member) { create :member, membership_level: membership_level }
  subject(:device) { build :device, member: member }

  before do
    allow_any_instance_of(Router).to receive(:ssh).and_return(true)
  end

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

  describe '#enabled?' do
    it 'should return enabled state' do
      expect(subject.enabled?).to be(true)
    end

    context 'disabled' do
      before do
        subject.enabled = false
      end

      it 'should return enabled state' do
        expect(subject.enabled?).to be(false)
      end
    end
  end

  describe "enable!" do
    before do
      subject.enabled = false
      subject.save!
    end

    it "disables the device" do
      expect { subject.enable! }.to change(device, :enabled).from(false).to(true)
    end
  end

  describe "enable!" do
    before do
      subject.enabled = true
      subject.save!
    end

    it "disables the device" do
      expect { subject.disable! }.to change(device, :enabled).from(true).to(false)
    end
  end

  describe 'before_create' do
    context 'belongs to hsv1-mem' do
      let(:type) { create :devices_type, hotspot: 'hsv1-mem' }
      let(:device) { build :device, type: type }

      it 'assigns an ip address' do
        device.save!
        expect(device.reload.ip_address).not_to be_nil
      end
    end

    context 'belongs to hsv2-bam' do
      let(:type) { create :devices_type, hotspot: 'hsv2-bam' }
      let(:device) { build :device, type: type }

      it 'does not assign an ip address' do
        device.save!
        expect(device.reload.ip_address).to be_nil
      end
    end
  end

  describe 'ip_address' do
    before do
      device.ip_address = '10.10.2.1/24'
      device.save!
    end

    it 'can store ip addresses' do
      expect(device.reload.ip_address).to eq('10.10.2.1/24')
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

  describe '#membership_network' do
    context 'membership level defines a network' do
      it 'returns the correct network for this members membership level' do
        expect(device.membership_network).to eq(membership_level.network)
      end
    end

    context 'membership level does not define a network' do
      before do
        device.member.membership_level.network = nil
      end

      it 'returns the correct network for this members membership level' do
        expect(device.membership_network).to eq('10.10.1.0/24')
      end
    end
  end

  describe '#renew' do
    it "renews a device's ip address" do
      device.renew
      expect(device.ip_address).to eq('10.10.2.1')
    end
  end

  describe '#renew!' do
    context 'first device in network' do
      it "renews and persists a device's ip address" do
        device.renew!
        expect(device.reload.ip_address).to eq('10.10.2.1')
      end
    end

    context 'second device in network' do
      before do
        create(:device, ip_address: '10.10.2.1')
      end

      it "renews and persists a device's ip address" do
        device.renew!
        expect(device.reload.ip_address).to eq('10.10.2.2')
      end
    end

    context 'the network is full' do
      it 'returns a sensible error message'
    end
  end

  describe '#release' do
    let!(:device) { create :device, ip_address: '10.10.2.1' }

    it "releases a device's ip address" do
      device.release
      expect(device.ip_address).to eq(nil)
    end
  end

  describe '#release!' do
    let!(:device) { create :device, ip_address: '10.10.2.1' }

    it "releases a device's ip address" do
      device.release!
      expect(device.reload.ip_address).to eq(nil)
    end
  end

  describe "#router_fields_changed?" do
    context "mac_address changed" do
      before do
        device.save!
        device.mac_address = "60:03:08:aa:85:39"
      end

      it "determines if any of the router fields changed" do
        expect(device.router_fields_changed?).to be true
      end
    end

    context "only enabled changed" do
      context 'disabled' do
        before do
          device.save!
          device.enabled = false
        end

        it "it sets @enabled_changed to be true" do
          expect{ device.save! }.to change{ device.instance_variable_get(:@enabled_changed) }.from(false).to(true)
        end
      end

      context 'enabled' do
        before do
          device.enabled = false
          device.save!
          device.enabled = true
        end

        it "it sets @enabled_changed to be true" do
          expect{ device.save! }.to change{ device.instance_variable_get(:@enabled_changed) }.from(false).to(true)
        end
      end
    end

    context "noting has changed" do
      before { device.save! }
      it "determines if any of the router fields changed" do
        expect(device.router_fields_changed?).to be false
      end
    end
  end

  describe "#after_save" do
    before do
      allow(device).to receive(:router_fields_changed?).and_return(true)
    end

    it "updates the router" do
      expect(device).to receive(:update_router)
      device.save!
    end
  end

  describe "#update_router" do
    it 'updates the device' do
      expect_any_instance_of(Router).to receive(:update).with(device)
      device.update_router
    end

    context "@enabled_changed is true" do
      before { device.instance_variable_set(:@enabled_changed, true) }

      context 'enabled is true' do
        before { device.enabled = true }

        it 'enables the device' do
          expect_any_instance_of(Router).to receive(:enable).with(device)
          device.update_router
        end
      end

      context 'enabled is false' do
        before { device.enabled = false }

        it 'disables the device' do
          expect_any_instance_of(Router).to receive(:disable).with(device)
          device.update_router
        end
      end
    end
  end
end
