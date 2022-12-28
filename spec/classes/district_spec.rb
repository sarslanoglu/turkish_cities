# frozen_string_literal: true

require_relative '../../lib/turkish_cities/district'

RSpec.describe District do
  describe '#list_neighborhoods' do
    context 'when input is supported' do
      it 'finds neighborhoods of given city and district' do
        expect(District.new('Artvin', 'Yusufeli').neighborhoods(nil).count).to eq 674
        expect(District.new('İstanbul', 'Adalar').neighborhoods(nil).count).to eq 5
        expect(District.new('Ankara', 'Mamak').neighborhoods(nil).count).to eq 64
        expect(District.new('İzmir', 'Konak').neighborhoods(nil).count).to eq 113
      end
    end
  end
end
