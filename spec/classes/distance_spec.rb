# frozen_string_literal: true

require_relative '../../lib/turkish_cities/distance'

RSpec.describe Distance do
  describe '#distance_between(land)' do
    context 'when input is supported' do
      it 'finds land distance between two location' do
        land_distance_results = Distance.new('Adana', 'Bolu', 'land').distance_between
        expect(land_distance_results[0]).to eq 690
        expect(land_distance_results[1])
          .to eq 'Land travel distance between Adana and Bolu is 690 km'
      end

      it 'finds land distance between two location when cities are not ordered on plate number' do
        land_distance_results = Distance.new('Zonguldak', 'Afyon', 'land').distance_between
        expect(land_distance_results[0]).to eq 488
        expect(land_distance_results[1])
          .to eq 'Land travel distance between Zonguldak and Afyon is 488 km'
      end
    end

    context 'when input is not supported' do
      it 'gives unsupported_travel_method_error' do
        expect(Distance.new('Adana', 'Adıyaman', 'time').distance_between)
          .to eq "Travel method 'time' is unsupported"
      end

      it 'gives city_not_found_error' do
        expect(Distance.new('Adansa', 'Adıyaman', 'land').distance_between)
          .to eq "Couldn't find cities combination with 'Adansa/Adıyaman'"
        expect(Distance.new('Kastamonu', 'falansa', 'land').distance_between)
          .to eq "Couldn't find cities combination with 'Kastamonu/falansa'"
        expect(Distance.new('filansa', 'falansa', 'land').distance_between)
          .to eq "Couldn't find cities combination with 'filansa/falansa'"
      end
    end
  end

  describe '#distance_between(air)' do
    context 'when input is supported' do
      it 'finds air distance between two location' do
        very_short_distance_results = Distance.new('Bolu', 'Kastamonu', 'air').distance_between
        expect(very_short_distance_results[0]).to eq 195.4
        expect(very_short_distance_results[1]).to eq 49
        expect(very_short_distance_results[2])
          .to eq 'Air travel distance between Bolu and Kastamonu is 195.4 km. ' \
                 'Estimated air travel would take 49 minutes'
        short_distance_results = Distance.new('İzmir', 'Antalya', 'air').distance_between
        expect(short_distance_results[0]).to eq 357.18
        expect(short_distance_results[1]).to eq 65
        expect(short_distance_results[2])
          .to eq 'Air travel distance between İzmir and Antalya is 357.18 km. ' \
                 'Estimated air travel would take 65 minutes'
        medium_distance_results = Distance.new('istanbul', 'Ordu', 'air').distance_between
        expect(medium_distance_results[0]).to eq 746.71
        expect(medium_distance_results[1]).to eq 96
        expect(medium_distance_results[2])
          .to eq 'Air travel distance between İstanbul and Ordu is 746.71 km. ' \
                 'Estimated air travel would take 96 minutes'
        long_distance_results = Distance.new('istanbul', 'kars', 'air').distance_between
        expect(long_distance_results[0]).to eq 1187.94
        expect(long_distance_results[1]).to eq 120
        expect(long_distance_results[2])
          .to eq 'Air travel distance between İstanbul and Kars is 1187.94 km. ' \
                 'Estimated air travel would take 120 minutes'
      end
    end

    context 'when input is not supported' do
      it 'gives unsupported_travel_method_error' do
        expect(Distance.new('Adana', 'Adıyaman', 'time').distance_between)
          .to eq "Travel method 'time' is unsupported"
      end

      it 'gives city_not_found_error' do
        expect(Distance.new('Adansa', 'Adıyaman', 'air').distance_between)
          .to eq "Couldn't find cities combination with 'Adansa/Adıyaman'"
        expect(Distance.new('Kastamonu', 'falansa', 'air').distance_between)
          .to eq "Couldn't find cities combination with 'Kastamonu/falansa'"
        expect(Distance.new('filansa', 'falansa', 'air').distance_between)
          .to eq "Couldn't find cities combination with 'filansa/falansa'"
      end
    end
  end
end
