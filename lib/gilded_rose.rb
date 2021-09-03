# frozen_string_literal: true

# This class acts as the Gilded rose shop and has the responsibility of updating items
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      edit_quality(item)
      edit_sell_in(item)
      edit_quality_when_sell_in_negative(item) if item.sell_in.negative?
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

  def edit_quality(item)
    if brie_or_tickets?(item)
      backstage_passes?(item) ? increase_tickets_quality(item) : increase_quality(item)
    else
      decrease_quality(item)
    end
  end

  def increase_tickets_quality(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
  end

  def edit_quality_when_sell_in_negative(item)
    brie_or_tickets?(item) ? edit_negative_brie_or_tickets(item) : decrease_quality(item)
  end

  def edit_negative_brie_or_tickets(item)
    aged_brie?(item) ? increase_quality(item) : item.quality = 0
  end

  def edit_sell_in(item)
    item.sell_in -= 1 unless sulfuras?(item)
  end
end
