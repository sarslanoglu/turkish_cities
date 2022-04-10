# frozen_string_literal: true

require_relative '../../lib/turkish_cities/city'

RSpec.describe City do
  describe '#find_by_id' do
    context 'when input is supported' do
      it 'finds city by plate number' do
        expect(City.new.find_by_id(6)).to eq 'Ankara'
        expect(City.new.find_by_id(0o07)).to eq 'Antalya'
        expect(City.new.find_by_id(26)).to eq 'Eskişehir'
        expect(City.new.find_by_id(43.0)).to eq 'Kütahya'
        expect(City.new.find_by_id('78')).to eq 'Karabük'
      end
    end

    context 'when input is not supported' do
      it 'gives out of bounds error' do
        expect { City.new.find_by_id(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 1 to 81')
        expect { City.new.find_by_id(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 1 to 81')
        expect { City.new.find_by_id('1000') }
          .to raise_error(RangeError, 'Given value [1000] is outside bounds of 1 to 81')
      end
    end
  end

  describe '#find_by_phone_code' do
    context 'when input is supported' do
      it 'finds city by phone code' do
        expect(City.new.find_by_phone_code(312)).to eq 'Ankara'
        expect(City.new.find_by_phone_code(242)).to eq 'Antalya'
        expect(City.new.find_by_phone_code(222)).to eq 'Eskişehir'
        expect(City.new.find_by_phone_code(274)).to eq 'Kütahya'
        expect(City.new.find_by_phone_code(212)).to eq 'İstanbul'
        expect(City.new.find_by_phone_code(216)).to eq 'İstanbul'
        expect(City.new.find_by_phone_code(370)).to eq 'Karabük'
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(City.new.find_by_phone_code(360))
          .to eq "Couldn't find city name with '360'"
      end

      it 'gives out of bounds error' do
        expect { City.new.find_by_phone_code(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 212 to 488')
        expect { City.new.find_by_phone_code(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 212 to 488')
        expect { City.new.find_by_phone_code('1000') }
          .to raise_error(RangeError, 'Given value [1000] is outside bounds of 212 to 488')
      end

      it 'gives error when phone code is not an even number' do
        expect { City.new.find_by_phone_code(213) }
          .to raise_error(ArgumentError, 'Given value [213] must be an even number')
      end
    end
  end

  describe '#find_by_name with plate number' do
    context 'when input is supported' do
      it 'finds plate number by city' do
        expect(City.new.find_by_name('Ankara', 'plate_number')).to eq 6
        expect(City.new.find_by_name('Canakkale', 'plate_number')).to eq 17
        expect(City.new.find_by_name('Eskişehir', 'plate_number')).to eq 26
        expect(City.new.find_by_name('Isparta', 'plate_number')).to eq 32
        expect(City.new.find_by_name('Istanbul', 'plate_number')).to eq 34
        expect(City.new.find_by_name('kirsehir', 'plate_number')).to eq 40
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(City.new.find_by_name('falansehir', 'plate_number'))
          .to eq "Couldn't find city name with 'falansehir'"
      end
    end
  end

  describe '#find_by_name with phone code' do
    context 'when input is supported' do
      it 'finds phone code by city' do
        expect(City.new.find_by_name('Ankara', 'phone_code')).to eq 312
        expect(City.new.find_by_name('Canakkale', 'phone_code')).to eq 286
        expect(City.new.find_by_name('Eskişehir', 'phone_code')).to eq 222
        expect(City.new.find_by_name('Isparta', 'phone_code')).to eq 246
        expect(City.new.find_by_name('Istanbul', 'phone_code')).to eq [212, 216]
        expect(City.new.find_by_name('kirsehir', 'phone_code')).to eq 386
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(City.new.find_by_name('filansehir', 'phone_code'))
          .to eq "Couldn't find city name with 'filansehir'"
      end
    end
  end

  describe '#list_cities' do
    context 'when listing without :with parameter' do
      it 'lists cities by plate number' do
        city_array = City.new.list_cities({})
        expect(city_array.size).to eq 81
        expect(city_array[41]).to eq 'Konya'
      end

      it 'lists cities by alphabetical order' do
        city_array = City.new.list_cities({ alphabetically_sorted: true })
        expect(city_array.size).to eq 81
        expect(city_array[39]).to eq 'İstanbul'
      end

      it 'lists only metropolitan municipality cities by plate number' do
        city_array = City.new.list_cities({ metropolitan_municipality: true })
        expect(city_array.size).to eq 30
        expect(city_array[14]).to eq 'İzmir'
      end

      it 'lists cities by region' do
        city_array = City.new.list_cities({ region: 'Karadeniz' })
        expect(city_array.size).to eq 18
        expect(city_array[17]).to eq 'Düzce'
      end

      it 'lists only metropolitan municipality cities by region' do
        city_array = City.new.list_cities({ region: 'Karadeniz',
                                            metropolitan_municipality: true })
        expect(city_array.size).to eq 3
        expect(city_array).to eq %w[Ordu Samsun Trabzon]
      end

      it 'lists only metropolitan municipality cities by alphabetical order' do
        city_array = City.new.list_cities({ alphabetically_sorted: true,
                                            metropolitan_municipality: true })
        expect(city_array.size).to eq 30
        expect(city_array[14]).to eq 'Kahramanmaraş'
      end

      it 'lists cities with all filters' do
        city_array = City.new.list_cities({ alphabetically_sorted: true,
                                            region: 'Marmara',
                                            metropolitan_municipality: true })
        expect(city_array.size).to eq 6
        expect(city_array).to eq %w[Balıkesir Bursa İstanbul Kocaeli Sakarya Tekirdağ]
      end

      it 'ignores wrong parameters' do
        city_array = City.new.list_cities({ falanicly_sorted: true })
        expect(city_array.size).to eq 81
        expect(city_array[33]).to eq 'İstanbul'
      end
    end

    context 'when listing with :with parameter' do
      it 'lists cities with their phone codes' do
        city_array = City.new.list_cities({ alphabetically_sorted: true,
                                            with: { phone_code: true } })
        first_city = { name: 'Adana', phone_code: 322 }
        expect(city_array[0]).to eq first_city
      end

      it 'lists cities with their plate numbers' do
        city_array = City.new.list_cities({ alphabetically_sorted: false,
                                            with: { plate_number: true } })

        first_city = { name: 'Adana', plate_number: 1 }
        expect(city_array[0]).to eq first_city
      end

      it 'lists cities with all parameters' do
        city_array = City.new.list_cities({ alphabetically_sorted: false,
                                            with: { all: true } })

        first_city = { metropolitan_municipality_since: 1986,
                       name: 'Adana',
                       phone_code: 322,
                       plate_number: 1,
                       region: 'Akdeniz' }
        expect(city_array[0]).to eq first_city
      end

      it 'ignores wrong parameters' do
        city_array = City.new.list_cities({ falanicly_sorted: true,
                                            with: { all: true } })
        expect(city_array.size).to eq 81
        city = { metropolitan_municipality_since: 1984,
                 name: 'İstanbul',
                 phone_code: [212, 216],
                 plate_number: 34,
                 region: 'Marmara' }
        expect(city_array[33]).to eq city
      end
    end
  end

  describe '#list_districts' do
    context 'when input is supported' do
      it 'finds districts of given city' do
        expect(City.new.list_districts('Ankara').length).to eq 25
        expect(City.new.list_districts('Eskişehir').length).to eq 14
        expect(City.new.list_districts('Isparta').length).to eq 13
        expect(City.new.list_districts('Istanbul').length).to eq 39
        expect(City.new.list_districts('Istanbul')).to include('Beşiktaş')
        expect(City.new.list_districts('kirsehir').length).to eq 7
        expect(City.new.list_districts('Bayburt')).to eq %w[Aydıntepe Demirözü Merkez]
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(City.new.list_districts('filansehir'))
          .to eq "Couldn't find city name with 'filansehir'"
      end
    end
  end
end
