require 'rails_helper'

describe Nexudus::Import::Billing::TariffClient do
  describe "#resources" do
    it "gets the tariffs" do
      expect(described_class).to receive(:get)
        .with(
          "/billing/tariffs",
          {
            basic_auth: {
              username: Rails.application.secrets.nexudus_username,
              password: Rails.application.secrets.nexudus_password
            }
          }
        )

      subject.resources
    end
  end
end
