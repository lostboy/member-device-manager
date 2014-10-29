require 'rails_helper'

describe Router do
  subject(:router) { Router.new }
  let(:device) { create :device }

  describe "#register" do
    it 'registers the device with the router' do
      device_info = {
        first_name: device.member.first_name,
        last_name: device.member.last_name,
        email: device.member.email,
        device_type: device.type.kind,
        mac_address: device.mac_address,
        ip_address: device.ip_address,
        hotspot: device.type.hotspot
      }
      arguments = router.hash_to_arguments device_info

      expect(router).to receive(:ssh).with("manager.rt", arguments)
      router.register device
    end
  end

  describe "#unregister" do
    it 'unregisters the device with the router' do
      device_info = { mac_address: device.mac_address }
      arguments = router.hash_to_arguments device_info

      expect(router).to receive(:ssh).with("manager.rt", arguments)
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
      device_info = { mac_address: device.mac_address, enable: true }
      arguments = router.hash_to_arguments device_info

      expect(router).to receive(:ssh).with("devable.rt", arguments)
      router.enable device
    end
  end

  describe "#disable" do
    it 'disables the device in the router' do
      device_info = { mac_address: device.mac_address, disable: true }
      arguments = router.hash_to_arguments device_info

      expect(router).to receive(:ssh).with("devable.rt", arguments)
      router.disable device
    end
  end

  describe "#ssh" do
    it 'executes given ssh command'
  end

  describe "#hash_to_arguments" do
    context 'all keys present' do
      it 'converts a hash to the proper ssh arguments' do
        hash = {
          first_name: 'Mark',
          last_name: 'Testlast',
          email: 'user@test.com',
          device_type: 'PC',
          mac_address: 'B8:E8:56:0A:E8:AC',
          ip_address: '10.10.10.110',
          hotspot: 'hsv1-mem'
        }
        arguments = router.hash_to_arguments hash
        expect(arguments).to eq("-f mark -l testlast -e user@test.com -t pc -m B8:E8:56:0A:E8:AC -i 10.10.10.110 -h hsv1-mem")
      end
    end

    context 'some keys present' do
      it 'converts a hash to the proper ssh arguments' do
        hash = {
          mac_address: 'B8:E8:56:0A:E8:AC'
        }
        arguments = router.hash_to_arguments hash
        expect(arguments).to eq("-m B8:E8:56:0A:E8:AC")
      end
    end

    context 'some keys blank present' do
      it 'converts a hash to the proper ssh arguments' do
        hash = {
          mac_address: 'B8:E8:56:0A:E8:AC',
          hotspot: ''
        }
        arguments = router.hash_to_arguments hash
        expect(arguments).to eq("-m B8:E8:56:0A:E8:AC")
      end
    end
  end
end
