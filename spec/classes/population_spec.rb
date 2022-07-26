# frozen_string_literal: true

require_relative '../../lib/turkish_cities/population'

RSpec.describe Population do
  describe '#find_by_population' do
    context 'when input is supported' do
      it 'finds city with exact population' do
        expect(Population.new.find_by_population('exact', 15_840_900, nil)).to eq %w[İstanbul]
        expect(Population.new.find_by_population('exact', 898_369, nil)).to eq %w[Eskişehir]
        expect(Population.new.find_by_population('exact', 2_130_432, nil)).to eq %w[Gaziantep]
      end

      it 'finds cities with below population' do
        expect(Population.new.find_by_population('below', 86_000, nil)).to eq %w[Tunceli Bayburt]
        expect(Population.new.find_by_population('below', 500_000, nil).length).to eq 38
        expect(Population.new.find_by_population('below', 15_840_900, nil).length).to eq 80
      end

      it 'finds cities with above population' do
        expect(Population.new.find_by_population('above', 86_000, nil).length).to eq 79
        expect(Population.new.find_by_population('above', 500_000, nil).length).to eq 43
        expect(Population.new.find_by_population('above', 5_000_000, nil)).to eq %w[Ankara İstanbul]
      end

      it 'finds cities between given populations' do
        expect(Population.new.find_by_population('between', 85_000, 100_000)).to eq %w[Bayburt Ardahan]
        expect(Population.new.find_by_population('between', 500_000, 1_000_000).length).to eq 19
        expect(Population.new.find_by_population('between', 3_000_000, 5_000_000)).to eq %w[Bursa İzmir]
      end
    end

    context 'when input is not supported' do
      it 'gives city_population_not_found_error' do
        expect(Population.new.find_by_population('exact', 100_000, nil))
          .to eq "Couldn't find any city with population data"
        expect(Population.new.find_by_population('between', 20_000_000, 100_000_000))
          .to eq "Couldn't find any city with population data"
      end

      it 'gives unsupported_population_type' do
        expect(Population.new.find_by_population('exatc', 100_000, nil))
          .to eq "Population type 'exatc' is unsupported"
      end

      it 'gives out of bounds error' do
        expect { Population.new.find_by_population('exact', nil, nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 83644 to 15840901')
        expect { Population.new.find_by_population('exact', 0, nil) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 83644 to 15840901')
        expect { Population.new.find_by_population('exact', 10_000, nil) }
          .to raise_error(RangeError, 'Given value [10000] is outside bounds of 83644 to 15840901')
        expect { Population.new.find_by_population('below', 10_000, nil) }
          .to raise_error(RangeError, 'Given value [10000] is outside bounds of 83644 to Infinity')
        expect { Population.new.find_by_population('above', 20_000_000, nil) }
          .to raise_error(RangeError, 'Given value [20000000] is outside bounds of 0 to 15840901')
      end
    end
  end
end
