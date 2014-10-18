require 'rails_helper'

describe Network do
  subject(:network) { Network.new '10.10.2.0/24' }

  describe '#to_s' do
    it 'returns a string representation of the network' do
      expect(network.to_s).to eq('10.10.2.0/24')
    end
  end

  describe '#first' do
    it 'returns the first ip address in this network' do
      expect(network.first.to_s).to eq('10.10.2.1')
    end
  end

  describe '#last' do
    it 'returns the last ip address in this network' do
      expect(network.last.to_s).to eq('10.10.2.254')
    end
  end

  describe '#taken' do
    before do
      create(:device, ip_address: '10.10.2.1')
      create(:device, ip_address: '10.10.2.3')
    end

    it 'returns the ip addresses taken' do
      expect(network.taken)
        .to eq(['10.10.2.1', '10.10.2.3'])
    end
  end

  describe '#available' do
    before do
      create(:device, ip_address: '10.10.2.1')
      create(:device, ip_address: '10.10.2.3')
    end

    it 'returns the available ip addresses' do
      expect(network.available.length).to eq(252)
    end
  end

  describe '#next' do
    before do
      create(:device, ip_address: '10.10.2.1')
      create(:device, ip_address: '10.10.2.3')
    end

    it 'returns the next available ip address' do
      expect(network.next).to eq('10.10.2.2')
    end
  end
end
