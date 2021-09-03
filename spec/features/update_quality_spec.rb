# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe '#update_quality' do
  context 'sellIn is more than 0' do
    before(:each) do
      @item = Item.new('foo', 5, 5)
      GildedRose.new([@item]).update_quality
    end

    it 'does not change the name' do
      expect(@item.name).to eq 'foo'
    end

    it 'reduces the sellIn by 1' do
      expect(@item.sell_in).to eq(4)
    end

    it 'reduces the quality by 1' do
      expect(@item.quality).to eq(4)
    end

    context 'item is Aged Brie' do
      before(:each) do
        @item = Item.new('Aged Brie', 5, 5)
        GildedRose.new([@item]).update_quality
      end

      it 'increases the quality' do
        expect(@item.quality).to eq(6)
      end
    end
  end

  context 'sellIn is less than 0' do
    before(:each) do
      @item = Item.new('foo', -1, 5)
      GildedRose.new([@item]).update_quality
    end

    it 'reduces the quality by 2' do
      expect(@item.quality).to eq(3)
    end

    context 'item is Aged Brie' do
      before(:each) do
        @item = Item.new('Aged Brie', -1, 5)
        GildedRose.new([@item]).update_quality
      end

      it 'increases the quality by 2' do
        expect(@item.quality).to eq(7)
      end
    end
  end

  context 'quality has reached 0' do
    before(:each) do
      @item = Item.new('foo', 5, 0)
      GildedRose.new([@item]).update_quality
    end

    it 'does not reduce the quality' do
      expect(@item.quality).to eq(0)
    end
  end

  it 'does not increase the quality once quality has reached 50' do
    @item = Item.new('Aged Brie', -1, 50)
    GildedRose.new([@item]).update_quality
    expect(@item.quality).to eq(50)
  end

  context 'item is Sulfuras' do
    before(:each) do
      @item = Item.new('Sulfuras, Hand of Ragnaros', 5, 5)
      GildedRose.new([@item]).update_quality
    end

    it 'does not change the sellIn' do
      expect(@item.sell_in).to eq(5)
    end

    it 'does note change the quality' do
      expect(@item.quality).to eq(5)
    end
  end

  context 'item is Backstage Passes' do
    it 'increases the quality' do
      @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 5)
      GildedRose.new([@item]).update_quality
      expect(@item.quality).to eq(6)
    end

    it 'increases the quality by 2 when sellIn is 10 or less' do
      @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 5)
      GildedRose.new([@item]).update_quality
      expect(@item.quality).to eq(7)
    end

    it 'increases the quality by 3 when sellIn is 5 or less' do
      @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 5)
      GildedRose.new([@item]).update_quality
      expect(@item.quality).to eq(8)
    end

    it 'sets the quality to 0 when sellIn is less than 0' do
      @item = Item.new('Backstage passes to a TAFKAL80ETC concert', -1, 5)
      GildedRose.new([@item]).update_quality
      expect(@item.quality).to eq(0)
    end
  end
end
