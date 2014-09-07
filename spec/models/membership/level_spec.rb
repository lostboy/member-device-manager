require 'rails_helper'

RSpec.describe Membership::Level, type: :model do
  subject(:level) { build :membership_level }

  describe '#to_s' do
    it 'returns the name' do
      expect(level.to_s)
        .to eq(level.name)
    end
  end
end
