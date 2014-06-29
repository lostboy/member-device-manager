require 'spec_helper'

shared_examples_for "a singleton" do
  describe "::instance" do
    subject { described_class }

    it "returns an instance of the importer" do
      expect(subject.instance).to be_a described_class
    end

    it "returns the same instance every time" do
      instance = subject.instance
      expect(subject.instance).to eq instance
    end
  end
end
