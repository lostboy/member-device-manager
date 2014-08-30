require 'rails_helper'

describe Devices::Device do
  subject(:device) { build :device }

  describe '.mac_address' do
    context 'is valid' do
      before { subject.mac_address = "08:00:2b:01:02:03"  }
      it "passes validation" do
        subject.valid?
        expect(subject.errors[:mac_address].size).to eq(0)
      end
    end

    context 'is invalid' do
      before { subject.mac_address = "0:00:2b:01:02:03"  }
      it "fails validation" do
        subject.valid?
        expect(subject.errors[:mac_address].size).to eq(1)
      end
    end

    context 'is missing' do
      before { subject.mac_address = nil }
      it "fails validation" do
        subject.valid?
        expect(subject.errors[:mac_address].size).to eq(2)
      end
    end
  end
end
