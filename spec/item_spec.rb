# frozen_string_literal: true

require 'item'

describe Item do
  name = 'Example name'
  sell_in = 10
  quality = 5
  subject { described_class.new(name, sell_in, quality) }

  describe '#to_s' do
    it 'displays the the attributes correctly' do
      expect(subject.to_s).to eq("#{name}, #{sell_in}, #{quality}")
    end
  end
end
