require 'rails_helper'

RSpec.describe Link, :vcr do
  it { should belong_to :linkable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }

  let(:valid_link) { create(:link, :valid_gist, :linkable)}
  let(:invalid_link) { create(:link, :invalid_gist, :linkable) }
  let(:link) { create :link, :linkable }

  describe '#gist_id' do
    it 'returns id for gist link' do
      expect(valid_link.send(:gist_id)).to eq '7e2f4bb9567fd10d5cb2a87a09ef875d'
    end

    it 'returns nil for not gist link' do
      expect(invalid_link.send(:gist_id)).to be_nil
    end
  end

  describe '#gist?' do
    it 'valid' do
      expect(valid_link).to be_gist
    end

    it 'invalid' do
      expect(invalid_link).to_not be_gist
    end
  end
end