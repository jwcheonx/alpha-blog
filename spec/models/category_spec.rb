require 'rails_helper'

RSpec.describe Category do
  context 'with name' do
    it 'is valid' do
      expect(described_class.new(name: 'Sports')).to be_valid
    end
  end

  context 'without name' do
    it 'is invalid' do
      c = described_class.new(name: ' ')
      c.validate

      expect(c.errors[:name]).to include("can't be blank")
    end
  end

  context 'when name is duplicate' do
    it 'is invalid' do
      c = described_class.create!(name: 'Sports').dup
      c.validate

      expect(c.errors[:name]).to include('has already been taken')
    end
  end

  context 'when name is too long' do
    it 'is invalid' do
      c = described_class.new(name: 'a' * 26)
      c.validate

      expect(c.errors[:name]).to include(/is too long/)
    end
  end

  context 'when name is too short' do
    it 'is invalid' do
      c = described_class.new(name: 'aa')
      c.validate

      expect(c.errors[:name]).to include(/is too short/)
    end
  end
end
