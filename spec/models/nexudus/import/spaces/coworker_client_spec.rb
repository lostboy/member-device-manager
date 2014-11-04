require 'rails_helper'

describe Nexudus::Import::Spaces::CoworkerClient do
  describe "#resources" do
    it "gets the coworkers" do
      expect(described_class).to receive(:get)
        .with(
          "/spaces/coworkers",
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
