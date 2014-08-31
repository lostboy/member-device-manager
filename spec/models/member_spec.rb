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

  describe '.email' do
    context 'is valid' do
      before { subject.email = "valid@email.com"  }
      it "passes validation" do
        subject.valid?
        expect(subject.errors[:email].size).to eq(0)
      end
    end

    context 'is invalid' do
      before { subject.email = "invalid-email"  }
      it "fails validation" do
        subject.valid?
        expect(subject.errors[:email].size).to eq(1)
      end
    end

    context 'is missing' do
      before { subject.email = nil }
      it "fails validation" do
        subject.valid?
        expect(subject.errors[:email].size).to eq(2)
      end
    end
  end

end
