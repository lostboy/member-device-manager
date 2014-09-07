require 'rails_helper'

RSpec.describe Nexudus::Import::Resource do
  describe "#save" do
    it "raises not implemented erorr" do
      expect { subject.save }.to raise_exception
    end
  end
end
