require 'rails_helper'

describe Member do
  subject(:member) { build :member }

  describe '#full_name' do
    it 'returns the full name' do
      expect(member.full_name)
        .to eq("#{member.first_name} #{member.last_name}")
    end
  end

  describe '#to_s' do
    it 'returns the full name' do
      expect(member.to_s).to eq(member.full_name)
    end
  end

  describe 'is_valid?' do
    it 'should have a valid factory' do
      expect(build :member).to be_valid
    end

    it 'should require an email' do
      expect(build :member, email: nil).not_to be_valid
    end

    it 'should require a correct email' do
      expect(build :member, email: 'foo').not_to be_valid
    end
  end

  describe "#router_fields_changed?" do
    context "first and last name changed" do
      before do
        member.save!
        member.first_name = "foo"
        member.last_name  = "bar"
      end

      it "determines if any of the router fields changed" do
        expect(member.router_fields_changed?).to be true
      end
    end

    context "only active changed" do
      context 'inactive' do
        before do
          member.active = true
          member.save!
          member.active = false
        end

        it "it sets @active_changed to be true" do
          expect{ member.save! }.to change{ member.instance_variable_get(:@active_changed) }.from(nil).to(true)
        end
      end

      context 'active' do
        before do
          member.active = false
          member.save!
          member.active = true
        end

        it "it sets @active_changed to be true" do
          expect{ member.save! }.to change{ member.instance_variable_get(:@active_changed) }.from(nil).to(true)
        end
      end
    end

    context "active didn't change" do
      before do
        member.active = false
        member.save!
        member.active = false
      end

      it "it sets @active_changed to be false" do
        expect{ member.save! }.to change{ member.instance_variable_get(:@active_changed) }.from(nil).to(false)
      end
    end

    context "noting has changed" do
      before { member.save! }
      it "determines if any of the router fields changed" do
        expect(member.router_fields_changed?).to be false
      end
    end
  end

  describe "#update_router" do
    let!(:member) { create :member }
    let!(:device) { create :device, member: member }

    context "@active_changed is true" do
      before { member.instance_variable_set(:@active_changed, true) }

      context "active" do
        before { member.active = true }

        it "enables the devices" do
          expect_any_instance_of(Devices::Device).to receive(:enable!)
          member.update_router
        end
      end

      context "inactive" do
        before { member.active = false }

        it "disables the devices" do
          expect_any_instance_of(Devices::Device).to receive(:disable!)
          member.update_router
        end
      end
    end

    it "updates the router" do
      expect_any_instance_of(Devices::Device).to receive(:update_router)
      member.update_router
    end
  end

  describe "#after_update" do
    before do
      member.save!
      allow(member).to receive(:router_fields_changed?).and_return(true)
    end

    it "updates the router" do
      expect(member).to receive(:update_router)
      member.save!
    end
  end

  describe "#after_create" do
    before do
      allow(member).to receive(:router_fields_changed?).and_return(true)
      allow(member).to receive(:update_router).and_return(true)
    end

    it "does not update the router" do
      expect(member).to_not have_received(:update_router)
      member.save!
    end
  end
end
