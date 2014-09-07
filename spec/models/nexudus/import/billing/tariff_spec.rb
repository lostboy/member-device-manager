require 'rails_helper'

describe Nexudus::Import::Billing::Tariff do
  it_behaves_like "a singleton"

  subject { described_class.instance }

  describe "#initialize" do
    subject { described_class.instance }

    it "creates a new tariff client" do
      expect(subject.client).to be_a Nexudus::Import::Billing::TariffClient
    end
  end

  describe "#update" do
    let(:page1) { ActiveSupport::JSON.decode(fixture('/nexudus/billing/tariffs_1.json')) }
    let(:page2) { ActiveSupport::JSON.decode(fixture('/nexudus/billing/tariffs_2.json')) }

    before do
      allow_any_instance_of(Nexudus::Import::Billing::TariffClient).to receive(:tariffs).and_return(page1, page2)
    end

    context 'membership levels in database' do
      let!(:level) { create :membership_level }

      it "fetches the tariffs" do
        expect_any_instance_of(Nexudus::Import::Billing::TariffClient).to receive(:tariffs)
          .with({ 'from_Tariff_UpdatedOn' => level.nexudus_updated_at.iso8601 })
          .and_return(page1, page2)

        subject.update
      end
    end

    context 'no tariffs in db' do
      it "fetches the tariffs" do
        expect_any_instance_of(Nexudus::Import::Billing::TariffClient).to receive(:tariffs)
          .with(nil)
          .and_return(page1, page2)

        subject.update
      end
    end

    it "adds new tariffs" do
      expect { subject.update }.to change(Membership::Level, :count).by 2
    end
  end
end
