# frozen_string_literal: true

require_relative '../../lib/turkish_cities/postcode'

RSpec.describe Postcode do
  describe '#find_by_postcode' do
    context 'when input is supported' do
      it 'finds city, district and subdistrict info of postcode' do
        expect(Postcode.new.find_by_postcode(34_380)).to eq %w[İstanbul Şişli Cumhuriyet]
        expect(Postcode.new.find_by_postcode(34_433)).to eq %w[İstanbul Beyoğlu Cihangir]
        expect(Postcode.new.find_by_postcode('26040')).to eq %w[Eskişehir Odunpazarı Büyükdere]
      end
    end

    context 'when input is not supported' do
      it 'gives postcode_not_found_error' do
        expect(Postcode.new.find_by_postcode(34_382))
          .to eq "Couldn't find any subdistrict with postcode '34382'"
      end

      it 'gives out of bounds error' do
        expect { Postcode.new.find_by_postcode(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 1010 to 81952')
        expect { Postcode.new.find_by_postcode(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 1010 to 81952')
        expect { Postcode.new.find_by_postcode('100000') }
          .to raise_error(RangeError, 'Given value [100000] is outside bounds of 1010 to 81952')
      end
    end
  end
end
