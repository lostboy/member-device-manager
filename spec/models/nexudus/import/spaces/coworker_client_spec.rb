require 'rails_helper'

describe Nexudus::Import::Spaces::CoworkerClient do
  describe "#resources" do
    it "gets the coworkers" do
      expect(described_class).to receive(:get)
        .with("/spaces/coworkers", {})

      subject.resources
    end
  end
end
