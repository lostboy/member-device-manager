require 'rails_helper'

describe Member do
  subject(:member) { build :member }

  describe '#full_name' do
    it 'returns the full name' do
      expect(member.full_name)
        .to eq("#{member.first_name} #{member.last_name}")
    end
  end

  describe '#to_s' do
    it 'returns the full name' do
      expect(member.to_s).to eq(member.full_name)
    end
  end

  describe 'is_valid?' do
    it 'should have a valid factory' do
      expect(build :member).to be_valid
    end

    it 'should require an email' do
      expect(build :member, email: nil).not_to be_valid
    end

    it 'should require a correct email' do
      expect(build :member, email: 'foo').not_to be_valid
    end
  end

end
