require 'rails_helper'

describe Nexudus::Import::Spaces::Coworker do
  it_behaves_like "a singleton"

  subject { described_class.instance }

  describe "#initialize" do
    subject { described_class.instance }

    it "creates a new coworker client" do
      expect(subject.client).to be_a Nexudus::Import::Spaces::CoworkerClient
    end
  end

  describe "#update" do
    let(:response) { ActiveSupport::JSON.decode(fixture('/nexudus/spaces/coworkers.json')) }

    before do
      allow_any_instance_of(Nexudus::Import::Spaces::CoworkerClient).to receive(:coworkers).and_return response
    end

    it "fetches the coworker" do
      expect_any_instance_of(Nexudus::Import::Spaces::CoworkerClient).to receive(:coworkers).and_return response
      subject.update
    end

    it "adds new coworkers" do
      expect { subject.update }.to change(User, :count).by 2
    end
  end
end
