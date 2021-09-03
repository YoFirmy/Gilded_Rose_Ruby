# frozen_string_literal: true

# This class acts as the Gilded rose shop and has the responsibility of updating items
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if brie_or_tickets?(item)
        increase_quality(item)
        if backstage_passes?(item)
          increase_quality(item) if item.sell_in < 11
          increase_quality(item) if item.sell_in < 6
        end
      else
        decrease_quality(item)
      end
      item.sell_in -= 1 unless sulfuras?(item)
      if item.sell_in.negative?
        if aged_brie?(item)
          increase_quality(item)
        elsif backstage_passes?(item)
          item.quality = 0
        else
          decrease_quality(item)
        end
      end
    end
  end

  private

  def backstage_passes?(item)
    item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def aged_brie?(item)
    item.name == 'Aged Brie'
  end

  def sulfuras?(item)
    item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality.positive? && !sulfuras?(item)
  end

  def brie_or_tickets?(item)
    aged_brie?(item) || backstage_passes?(item)
  end
end
