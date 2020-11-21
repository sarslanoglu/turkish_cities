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

  describe '#list_cities' do
    context 'when listing without :with parameter' do
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
    end

    context 'when listing with :with parameter' do
      it 'lists cities with their phone codes' do
        city_array = TurkishCities.list_cities({ alphabetically_sorted: true,
                                                 with: { phone_code: true } })
        first_city = { name: 'Adana', phone_code: 322 }
        expect(city_array[0]).to eq first_city
      end

      it 'lists cities with their plate numbers' do
        city_array = TurkishCities.list_cities({ alphabetically_sorted: false,
                                                 with: { plate_number: true } })

        first_city = { name: 'Adana', plate_number: 1 }
        expect(city_array[0]).to eq first_city
      end

      it 'lists cities with all parameters' do
        city_array = TurkishCities.list_cities({ alphabetically_sorted: false,
                                                 with: { all: true } })

        first_city = { metropolitan_municipality_since: 1986,
                       name: 'Adana',
                       phone_code: 322,
                       plate_number: 1,
                       region: 'Akdeniz' }
        expect(city_array[0]).to eq first_city
      end

      it 'ignores wrong parameters' do
        city_array = TurkishCities.list_cities({ falanicly_sorted: true,
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

  describe '#distance_between' do
    context 'when input is supported' do
      it 'finds air distance between two location' do
        very_short_distance_results = TurkishCities.distance_between('Bolu', 'Kastamonu', 'air')
        expect(very_short_distance_results[0]).to eq 195.4
        expect(very_short_distance_results[1]).to eq 49
        expect(very_short_distance_results[2])
          .to eq 'Air travel distance between Bolu and Kastamonu is 195.4 km. '\
            'Estimated air travel would take 49 minutes.'
        short_distance_results = TurkishCities.distance_between('İzmir', 'Antalya', 'air')
        expect(short_distance_results[0]).to eq 357.18
        expect(short_distance_results[1]).to eq 65
        expect(short_distance_results[2])
          .to eq 'Air travel distance between İzmir and Antalya is 357.18 km. '\
            'Estimated air travel would take 65 minutes.'
        medium_distance_results = TurkishCities.distance_between('istanbul', 'Ordu', 'air')
        expect(medium_distance_results[0]).to eq 746.71
        expect(medium_distance_results[1]).to eq 96
        expect(medium_distance_results[2])
          .to eq 'Air travel distance between İstanbul and Ordu is 746.71 km. '\
            'Estimated air travel would take 96 minutes.'
        long_distance_results = TurkishCities.distance_between('istanbul', 'kars', 'air')
        expect(long_distance_results[0]).to eq 1187.94
        expect(long_distance_results[1]).to eq 120
        expect(long_distance_results[2])
          .to eq 'Air travel distance between İstanbul and Kars is 1187.94 km. '\
            'Estimated air travel would take 120 minutes.'
      end
    end

    context 'when input is not supported' do
      it 'gives unsupported_travel_method_error' do
        expect(TurkishCities.distance_between('Adana', 'Adıyaman', 'time'))
          .to eq "Travel method 'time' is unsupported"
      end

      it 'gives city_not_found_error' do
        expect(TurkishCities.distance_between('Adansa', 'Adıyaman', 'air'))
          .to eq "Couldn't find cities combination with 'Adansa/Adıyaman'"
        expect(TurkishCities.distance_between('Kastamonu', 'falansa', 'air'))
          .to eq "Couldn't find cities combination with 'Kastamonu/falansa'"
        expect(TurkishCities.distance_between('filansa', 'falansa', 'air'))
          .to eq "Couldn't find cities combination with 'filansa/falansa'"
      end
    end
  end

  describe '#list_subdistricts' do
    context 'when input is supported' do
      it 'finds districts of given city' do
        expect(TurkishCities.list_subdistricts('Adana', 'Seyhan').length).to eq 21
        expect(TurkishCities.list_subdistricts('Eskişehir', 'Odunpazarı').length).to eq 15
        expect(TurkishCities.list_subdistricts('Afyon', 'Başmakçı')).to eq %w[Başmakçı Merkezköyler]
        expect(TurkishCities.list_subdistricts('Istanbul', 'Beşiktaş'))
          .to eq %w[Abbasağa Akatlar Arnavutköy Bebek Etiler Gayrettepe Levazım Levent Ortaköy
                    Türkali]
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.list_subdistricts('filansehir', 'Beşiktaş'))
          .to eq "Couldn't find district name with 'Beşiktaş' of 'filansehir'"
        expect(TurkishCities.list_subdistricts('İstanbul', 'filanmevki'))
          .to eq "Couldn't find district name with 'filanmevki' of 'İstanbul'"
      end
    end
  end

  describe '#list_neighborhoods' do
    context 'when input is supported' do
      it 'finds neighborhoods of given city and district without subdistrict info' do
        expect(TurkishCities.list_neighborhoods('Adana', 'Seyhan').length).to eq 96
        expect(TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı').length).to eq 86
        expect(TurkishCities.list_neighborhoods('Istanbul', 'Beşiktaş'))
          .to include('Abbasağa Mah', 'Ortaköy Mah', 'Sinanpaşa Mah', 'Vişnezade Mah')
      end
    end

    context 'when input is supported' do
      it 'finds neighborhoods of given city and district with subdistrict info' do
        expect(TurkishCities.list_neighborhoods('Adana', 'Seyhan', 'Emek'))
          .to eq ['Emek Mah', 'Ova Mah', 'Şakirpaşa Mah', 'Uçak Mah']
        expect(TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı', 'Büyükdere'))
          .to eq ['Büyükdere Mah', 'Göztepe Mah', 'Gültepe Mah', 'Yıldıztepe Mah']
        expect(TurkishCities.list_neighborhoods('Istanbul', 'Beşiktaş', 'Gayrettepe'))
          .to eq ['Balmumcu Mah', 'Dikilitaş Mah', 'Gayrettepe Mah', 'Yıldız Mah']
      end
    end

    context 'when input is not supported' do
      it 'gives city_not_found_error' do
        expect(TurkishCities.list_neighborhoods('filansehir', 'Beşiktaş'))
          .to eq "Couldn't find district name with 'Beşiktaş' of 'filansehir'"
        expect(TurkishCities.list_neighborhoods('İstanbul', 'filanmevki'))
          .to eq "Couldn't find district name with 'filanmevki' of 'İstanbul'"
        expect(TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı', 'Büyükkkkkdere'))
          .to eq "Couldn't find subdistrict with 'Büyükkkkkdere' of 'Odunpazarı'/'Eskişehir'"
      end
    end
  end

  describe '#find_by_postcode' do
    context 'when input is supported' do
      it 'finds city, district and subdistrict info of postcode' do
        expect(TurkishCities.find_by_postcode(34_380)).to eq %w[İstanbul Şişli Cumhuriyet]
        expect(TurkishCities.find_by_postcode(34_433)).to eq %w[İstanbul Beyoğlu Cihangir]
        expect(TurkishCities.find_by_postcode('26040')).to eq %w[Eskişehir Odunpazarı Büyükdere]
      end
    end

    context 'when input is not supported' do
      it 'gives postcode_not_found_error' do
        expect(TurkishCities.find_by_postcode(34_382))
          .to eq "Couldn't find any subdistrict with postcode '34382'"
      end

      it 'gives out of bounds error' do
        expect { TurkishCities.find_by_postcode(nil) }
          .to raise_error(RangeError, 'Given value [] is outside bounds of 1010 to 81952.')
        expect { TurkishCities.find_by_postcode(0) }
          .to raise_error(RangeError, 'Given value [0] is outside bounds of 1010 to 81952.')
        expect { TurkishCities.find_by_postcode('100000') }
          .to raise_error(RangeError, 'Given value [100000] is outside bounds of 1010 to 81952.')
      end
    end
  end
end
