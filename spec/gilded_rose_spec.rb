# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:item) { double :item, name: 'foo', quality: 5, sell_in: 5, :sell_in= => 4, :quality= => 4 }
  subject { described_class.new([item])}

  describe '#update_quality' do
    it 'does not change the name' do
      expect(item).not_to receive(:name=)
      subject.update_quality
    end

    it 'reduces the sellIn number by 1' do
      expect(item).to receive(:sell_in=).with(item.sell_in - 1)
      subject.update_quality
    end
  end
end
