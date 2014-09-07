require 'rails_helper'

describe Nexudus::Import::Billing::TariffClient do
  describe "#tariffs" do
    it "gets the tariffs" do
      expect(described_class).to receive(:get)
        .with("/billing/tariffs", {})

      subject.tariffs
    end
  end
end
