# frozen_string_literal: true

require_relative '../lib/turkish_cities'

RSpec.describe TurkishCities do
  describe '#find_name_by_plate_number' do
    context 'when input is supported' do
      it 'finds city by plate number' do
        expect(TurkishCities.find_name_by_plate_number(6)).to eq 'Ankara'
        expect(TurkishCities.find_name_by_plate_number(0o07)).to eq 'Antalya'
        expect(TurkishCities.find_name_by_plate_number(26)).to eq 'Eskişehir'
        expect(TurkishCities.find_name_by_plate_number(43.0)).to eq 'Kütahya'
        expect(TurkishCities.find_name_by_plate_number('78')).to eq 'Karabük'
      end
    end

    context 'when input is not supported' do
      it 'gives out of bounds error' do
        expect { TurkishCities.find_name_by_plate_number(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 1 to 81.')
        expect { TurkishCities.find_name_by_plate_number(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 1 to 81.')
        expect { TurkishCities.find_name_by_plate_number('1000') }
          .to raise_error(RangeError, 'Given value [1000] is outside bounds of 1 to 81.')
      end
    end
  end

  describe '#find_name_by_phone_code' do
    context 'when input is supported' do
      it 'finds city by phone code' do
        expect(TurkishCities.find_name_by_phone_code(312)).to eq 'Ankara'
        expect(TurkishCities.find_name_by_phone_code(242)).to eq 'Antalya'
        expect(TurkishCities.find_name_by_phone_code(222)).to eq 'Eskişehir'
        expect(TurkishCities.find_name_by_phone_code(274)).to eq 'Kütahya'
        expect(TurkishCities.find_name_by_phone_code(212)).to eq 'İstanbul'
        expect(TurkishCities.find_name_by_phone_code(216)).to eq 'İstanbul'
        expect(TurkishCities.find_name_by_phone_code(370)).to eq 'Karabük'
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.find_name_by_phone_code(360))
          .to eq "Couldn't find city name with '360'"
      end

      it 'gives out of bounds error' do
        expect { TurkishCities.find_name_by_phone_code(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 212 to 488.')
        expect { TurkishCities.find_name_by_phone_code(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 212 to 488.')
        expect { TurkishCities.find_name_by_phone_code('1000') }
          .to raise_error(RangeError, 'Given value [1000] is outside bounds of 212 to 488.')
      end

      it 'gives error when phone code is not an even number' do
        expect { TurkishCities.find_name_by_phone_code(213) }
          .to raise_error(ArgumentError, 'Given value [213] must be an even number.')
      end
    end
  end

  describe '#find_plate_number_by_name' do
    context 'when input is supported' do
      it 'finds plate number by city' do
        expect(TurkishCities.find_plate_number_by_name('Ankara')).to eq 6
        expect(TurkishCities.find_plate_number_by_name('Canakkale')).to eq 17
        expect(TurkishCities.find_plate_number_by_name('Eskişehir')).to eq 26
        expect(TurkishCities.find_plate_number_by_name('Isparta')).to eq 32
        expect(TurkishCities.find_plate_number_by_name('Istanbul')).to eq 34
        expect(TurkishCities.find_plate_number_by_name('kirsehir')).to eq 40
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.find_plate_number_by_name('falansehir'))
          .to eq "Couldn't find city name with 'falansehir'"
      end
    end
  end

  describe '#find_phone_code_by_name' do
    context 'when input is supported' do
      it 'finds phone code by city' do
        expect(TurkishCities.find_phone_code_by_name('Ankara')).to eq 312
        expect(TurkishCities.find_phone_code_by_name('Canakkale')).to eq 286
        expect(TurkishCities.find_phone_code_by_name('Eskişehir')).to eq 222
        expect(TurkishCities.find_phone_code_by_name('Isparta')).to eq 246
        expect(TurkishCities.find_phone_code_by_name('Istanbul')).to eq [212, 216]
        expect(TurkishCities.find_phone_code_by_name('kirsehir')).to eq 386
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.find_phone_code_by_name('filansehir'))
          .to eq "Couldn't find city name with 'filansehir'"
      end
    end
  end

  it 'lists districts of İstanbul' do
    istanbul_districts = TurkishCities.list_districts('İstanbul')
    expect(istanbul_districts.size).to eq 39
    expect(istanbul_districts[5]).to eq 'Bahçelievler'
  end

  it 'lists districts of Kilis' do
    kilis_districts = TurkishCities.list_districts('Kilis')
    expect(kilis_districts.size).to eq 4
    expect(kilis_districts).to eq %w[Elbeyli Merkez Musabeyli Polateli]
  end

  it 'gives error when city_name is not found' do
    unknown_districts = TurkishCities.list_districts('Haleluya')
    expect(unknown_districts).to eq "Couldn't find city name with 'Haleluya'"
  end

  it 'lists cities by plate number' do
    city_array = TurkishCities.list_cities
    expect(city_array.size).to eq 81
    expect(city_array[41]).to eq 'Konya'
  end

  it 'lists cities by alphabetical order' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true })
    expect(city_array.size).to eq 81
    expect(city_array[39]).to eq 'İstanbul'
  end

  it 'lists only metropolitan municipality cities by plate number' do
    city_array = TurkishCities.list_cities({ metropolitan_municipality: true })
    expect(city_array.size).to eq 30
    expect(city_array[14]).to eq 'İzmir'
  end

  it 'lists cities by region' do
    city_array = TurkishCities.list_cities({ region: 'Karadeniz' })
    expect(city_array.size).to eq 18
    expect(city_array[17]).to eq 'Düzce'
  end

  it 'lists only metropolitan municipality cities by region' do
    city_array = TurkishCities.list_cities({ region: 'Karadeniz',
                                             metropolitan_municipality: true })
    expect(city_array.size).to eq 3
    expect(city_array).to eq %w[Ordu Samsun Trabzon]
  end

  it 'lists only metropolitan municipality cities by alphabetical order' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true,
                                             metropolitan_municipality: true })
    expect(city_array.size).to eq 30
    expect(city_array[14]).to eq 'Kahramanmaraş'
  end

  it 'lists cities with all filters' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true,
                                             region: 'Marmara',
                                             metropolitan_municipality: true })
    expect(city_array.size).to eq 6
    expect(city_array).to eq %w[Balıkesir Bursa İstanbul Kocaeli Sakarya Tekirdağ]
  end

  it 'ignores wrong parameters' do
    city_array = TurkishCities.list_cities({ falanicly_sorted: true })
    expect(city_array.size).to eq 81
    expect(city_array[33]).to eq 'İstanbul'
  end

  describe '#list_districts' do
    context 'when input is supported' do
      it 'finds districts of given city' do
        expect(TurkishCities.list_districts('Ankara').length).to eq 25
        expect(TurkishCities.list_districts('Eskişehir').length).to eq 14
        expect(TurkishCities.list_districts('Isparta').length).to eq 13
        expect(TurkishCities.list_districts('Istanbul').length).to eq 39
        expect(TurkishCities.list_districts('Istanbul')).to include('Beşiktaş')
        expect(TurkishCities.list_districts('kirsehir').length).to eq 7
        expect(TurkishCities.list_districts('Bayburt')).to eq %w[Aydıntepe Demirözü Merkez]
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.list_districts('filansehir'))
          .to eq "Couldn't find city name with 'filansehir'"
      end
    end
  end

  describe '#list_subdistricts' do
    context 'when input is supported' do
      it 'finds districts of given city' do
        expect(TurkishCities.list_subdistricts('Adana', 'Seyhan').length).to eq 21
        expect(TurkishCities.list_subdistricts('Eskişehir', 'Odunpazarı').length).to eq 15
        expect(TurkishCities.list_subdistricts('Istanbul', 'Beşiktaş'))
          .to eq %w[Abbasağa Akatlar Arnavutköy Bebek Etiler Gayrettepe Levazım Levent Ortaköy
                    Türkali]
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.list_subdistricts('İstanbul', 'filanmevki'))
          .to eq "Couldn't find district name with 'filanmevki' of 'İstanbul'"
      end
    end
  end
end
