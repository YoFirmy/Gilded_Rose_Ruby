# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:item) { double :item, name: 'foo', quality: 5, sell_in: 5, :sell_in= => 4, :quality= => 4 }
  subject { described_class.new([item]) }

  describe '#update_quality' do
    it 'does not change the name' do
      expect(item).not_to receive(:name=)
      subject.update_quality
    end

    it 'reduces the sellIn by 1' do
      expect(item).to receive(:sell_in=).with(item.sell_in - 1)
      subject.update_quality
    end

    it 'reduces the quality by 1' do
      expect(item).to receive(:quality=).with(item.quality - 1)
      subject.update_quality
    end

    it 'reduces the quality by 2 when sellIn has passed' do
      allow(item).to receive(:sell_in).and_return(-1)
      expect(item).to receive(:quality=).with(item.quality - 1).twice
      subject.update_quality
    end

    it 'does not reduce the quality once it has reached 0' do
      allow(item).to receive(:quality).and_return(0)
      expect(item).not_to receive(:quality=)
      subject.update_quality
    end

    it 'increases the quality of Aged Brie' do
      allow(item).to receive(:name).and_return('Aged Brie')
      expect(item).to receive(:quality=).with(item.quality + 1)
      subject.update_quality
    end

    it 'increases the quality of Aged Brie by 2 when sellIn has passed' do
      allow(item).to receive(:sell_in).and_return(-1)
      allow(item).to receive(:name).and_return('Aged Brie')
      expect(item).to receive(:quality=).with(item.quality + 1).twice
      subject.update_quality
    end

    it 'does not increase the quality once it has reached 50' do
      allow(item).to receive(:quality).and_return(50)
      allow(item).to receive(:name).and_return('Aged Brie')
      expect(item).not_to receive(:quality=)
      subject.update_quality
    end

    it 'does not change the sellIn of Sulfuras' do
      allow(item).to receive(:name).and_return('Sulfuras, Hand of Ragnaros')
      expect(item).not_to receive(:sell_in=)
      subject.update_quality
    end

    it 'does note change the quality of Sulfuras' do
      allow(item).to receive(:name).and_return('Sulfuras, Hand of Ragnaros')
      expect(item).not_to receive(:quality=)
      subject.update_quality
    end

    it 'increases the quality of Backstage Passes' do
      allow(item).to receive(:name).and_return('Backstage passes to a TAFKAL80ETC concert')
      allow(item).to receive(:sell_in).and_return(11)
      expect(item).to receive(:quality=).with(item.quality + 1)
      subject.update_quality
    end

    it 'increases the quality of Backstage Passes by 2 when sellIn is 10 or less' do
      allow(item).to receive(:name).and_return('Backstage passes to a TAFKAL80ETC concert')
      allow(item).to receive(:sell_in).and_return(10)
      expect(item).to receive(:quality=).with(item.quality + 1).twice
      subject.update_quality
    end

    it 'increases the quality of Backstage Passes by 3 when sellIn is 5 or less' do
      allow(item).to receive(:name).and_return('Backstage passes to a TAFKAL80ETC concert')
      allow(item).to receive(:sell_in).and_return(5)
      expect(item).to receive(:quality=).with(item.quality + 1).exactly(3).times
      subject.update_quality
    end

    it 'sets the quality of Backstage Passes to 0 when sellIn is less than 0' do
      allow(item).to receive(:name).and_return('Backstage passes to a TAFKAL80ETC concert')
      allow(item).to receive(:sell_in).and_return(-1)
      expect(item).to receive(:quality=).with(0)
      subject.update_quality
    end

    it 'decreases the quality of conjured items by 2' do
      allow(item).to receive(:name).and_return('Conjured Mana Cake')
      allow(item).to receive(:sell_in).and_return(5)
      expect(item).to receive(:quality=).with(4).twice
      subject.update_quality
    end

    it 'decreases the quality of conjured items by 4 if sellIn is less than 0' do
      allow(item).to receive(:name).and_return('Conjured Mana Cake')
      allow(item).to receive(:sell_in).and_return(-1)
      expect(item).to receive(:quality=).with(4).exactly(4).times
      subject.update_quality
    end
  end
end
