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
    let(:page1) { ActiveSupport::JSON.decode(fixture('/nexudus/spaces/coworkers_1.json')) }
    let(:page2) { ActiveSupport::JSON.decode(fixture('/nexudus/spaces/coworkers_2.json')) }

    before do
      allow_any_instance_of(Nexudus::Import::Spaces::CoworkerClient).to receive(:coworkers).and_return(page1, page2)
    end

    context 'members in database' do
      let(:member) { create :member }

      it "fetches the coworkers" do
        expect_any_instance_of(Nexudus::Import::Spaces::CoworkerClient).to receive(:coworkers)
          .with({ 'from_Coworker_UpdatedOn' => member.nexudus_updated_at.iso8601 })
          .and_return(page1, page2)

        subject.update
      end
    end

    context 'no members in db' do
      it "fetches the coworkers" do
        expect_any_instance_of(Nexudus::Import::Spaces::CoworkerClient).to receive(:coworkers)
          .with(nil)
          .and_return(page1, page2)

        subject.update
      end
    end

    it "adds new coworkers" do
      expect { subject.update }.to change(Member, :count).by 2
    end
  end
end
