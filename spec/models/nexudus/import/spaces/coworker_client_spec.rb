require 'rails_helper'

describe Nexudus::Import::Spaces::CoworkerClient do
  describe "#coworkers" do
    it "gets the coworkers" do
      expect(described_class).to receive(:get)
        .with("/spaces/coworkers", {})

      subject.coworkers
    end
  end
end
