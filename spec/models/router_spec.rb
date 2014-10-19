require 'rails_helper'

describe Router do
  subject(:router) { Router.new }
  let(:device) { create :device }

  describe "#register" do
    it 'registers the device with the router' do
      device_info = [
        device.member.first_name,
        device.member.last_name,
        device.member.email,
        device.type.kind,
        device.mac_address,
        device.ip_address,
        device.type.hotspot
      ]
      argument = device_info.join(",")

      expect(router).to receive(:ssh).with("rt.add.device", argument)
      router.register device
    end
  end

  describe "#unregister" do
    it 'unregisters the device with the router' do
      expect(router).to receive(:ssh).with("rt.remove.device", device.mac_address)
      router.unregister device
    end
  end

  describe "#update" do
    it 'updates a device in the router' do
      expect(router).to receive(:unregister).with(device)
      expect(router).to receive(:register).with(device)
      router.update device
    end
  end

  describe "#enable" do
    it 'enables the device in the router' do
      expect(router).to receive(:ssh).with("rt.enable.device", device.mac_address)
      router.enable device
    end
  end

  describe "#disable" do
    it 'disables the device in the router' do
      expect(router).to receive(:ssh).with("rt.disable.device", device.mac_address)
      router.disable device
    end
  end

  describe "#update_ip_address" do
    it 'updates a devices ip address in the router' do
      device_info = [
        device.member.first_name,
        device.member.last_name,
        device.member.email,
        device.type.kind,
        device.mac_address,
        device.ip_address,
        device.type.hotspot
      ]
      argument = device_info.join(",")

      expect(router).to receive(:ssh).with("rt.mgr.dhcp", argument)
      router.update_ip_address device
    end
  end

  describe "#ssh" do
    it 'executes given ssh command'
  end
end
