# frozen_string_literal: true

require_relative '../../lib/turkish_cities/elevation'

RSpec.describe Elevation do
  describe '#find_by_elevation' do
    context 'when input is supported' do
      it 'finds cities with below elevation' do
        expect(Elevation.new.find_by_elevation('below', 5, nil)).to eq %w[Kocaeli]
        expect(Elevation.new.find_by_elevation('below', 100, nil).length).to eq 22
        expect(Elevation.new.find_by_elevation('below', 1000, nil).length).to eq 57
      end

      it 'finds cities with above elevation' do
        expect(Elevation.new.find_by_elevation('above', 5, nil).length).to eq 80
        expect(Elevation.new.find_by_elevation('above', 100, nil).length).to eq 59
        expect(Elevation.new.find_by_elevation('above', 1800, nil)).to eq %w[Erzurum]
      end

      it 'finds cities between given elevations' do
        expect(Elevation.new.find_by_elevation('between', 10, 20)).to eq %w[Çanakkale Giresun Mersin Rize Bartın]
        expect(Elevation.new.find_by_elevation('between', 500, 1000).length).to eq 27
        expect(Elevation.new.find_by_elevation('between', 1700, 1923)).to eq %w[Hakkari Kars Van Ardahan]
      end
    end

    context 'when input is not supported' do
      it 'gives city_elevation_not_found_error' do
        expect(Elevation.new.find_by_elevation('between', 1000, 1001))
          .to eq "Couldn't find any city with elevation data"
      end

      it 'gives unsupported_elevation_type' do
        expect(Elevation.new.find_by_elevation('exatc', 1000, nil))
          .to eq "Elevation type 'exatc' is unsupported"
      end

      it 'gives out of bounds error' do
        expect(Elevation.new.find_by_elevation('above', nil, nil)).to eq %w[]
        expect(Elevation.new.find_by_elevation('below', 0, nil)).to eq %w[]
        expect(Elevation.new.find_by_elevation('above', 10_000, nil)).to eq %w[]
        expect(Elevation.new.find_by_elevation('between', 100_000, 100_000_000)).to eq %w[]
      end
    end
  end
end
