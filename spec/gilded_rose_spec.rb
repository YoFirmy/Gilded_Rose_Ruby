# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:item) { double :item, name: 'foo', quality: 0, sell_in: 0, :sell_in= => -1 }
  subject { described_class.new([item])}

  describe '#update_quality' do
    it 'does not change the name' do
      subject.update_quality
      expect(item).not_to receive(:name=)
    end
  end
end
