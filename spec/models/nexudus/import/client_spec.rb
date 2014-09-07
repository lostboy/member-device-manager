require 'rails_helper'

RSpec.describe Nexudus::Import::Client do
  describe "#resources" do
    it "raises not implemented erorr" do
      expect { subject.resources }.to raise_exception
    end
  end
end
