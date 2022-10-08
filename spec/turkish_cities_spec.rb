# frozen_string_literal: true

require_relative '../lib/turkish_cities'

RSpec.describe TurkishCities do
  describe '#change_locale' do
    context 'when input is supported' do
      it 'changes to turkish' do
        expect(TurkishCities.change_locale('tr')).to eq 'Dil Türkçe olarak ayarlandı'
      end

      it 'changes to english' do
        expect(TurkishCities.change_locale('en')).to eq 'Language set to English'
      end
    end

    context 'when input is not supported' do
      it 'gives error' do
        expect(TurkishCities.change_locale(nil))
          .to eq "Unsupported language code. Please use 'tr' for Turkish, 'en' for English"
        expect(TurkishCities.change_locale('fr'))
          .to eq "Unsupported language code. Please use 'tr' for Turkish, 'en' for English"
      end
    end
  end

  describe '#find_name_by_plate_number' do
    context 'when input is supported' do
      it 'finds city by plate number' do
        expect(TurkishCities.find_name_by_plate_number(6)).to eq 'Ankara'
      end
    end
  end

  describe '#find_name_by_phone_code' do
    context 'when input is supported' do
      it 'finds city by phone code' do
        expect(TurkishCities.find_name_by_phone_code(312)).to eq 'Ankara'
      end
    end
  end

  describe '#find_plate_number_by_name' do
    context 'when input is supported' do
      it 'finds plate number by city' do
        expect(TurkishCities.find_plate_number_by_name('Ankara')).to eq 6
      end
    end
  end

  describe '#find_phone_code_by_name' do
    context 'when input is supported' do
      it 'finds phone code by city' do
        expect(TurkishCities.find_phone_code_by_name('Ankara')).to eq 312
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
    end
  end

  describe '#list_districts' do
    context 'when input is supported' do
      it 'finds districts of given city' do
        expect(TurkishCities.list_districts('Ankara').length).to eq 25
      end
    end
  end

  describe '#distance_between(land)' do
    context 'when input is supported' do
      it 'finds land distance between two location' do
        land_distance_results = TurkishCities.distance_between('Adana', 'Bolu', 'land')
        expect(land_distance_results[0]).to eq 690
        expect(land_distance_results[1])
          .to eq 'Land travel distance between Adana and Bolu is 690 km'
      end
    end
  end

  describe '#distance_between(air)' do
    context 'when input is supported' do
      it 'finds air distance between two location' do
        very_short_distance_results = TurkishCities.distance_between('Bolu', 'Kastamonu', 'air')
        expect(very_short_distance_results[0]).to eq 195.4
        expect(very_short_distance_results[1]).to eq 49
        expect(very_short_distance_results[2])
          .to eq 'Air travel distance between Bolu and Kastamonu is 195.4 km. ' \
                 'Estimated air travel would take 49 minutes'
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

  describe '#find_by_elevation' do
    context 'when input is supported' do
      it 'finds city with below elevation' do
        expect(TurkishCities.find_by_elevation('below', 5)).to eq %w[Kocaeli]
      end
    end
  end

  describe '#find_by_population' do
    context 'when input is supported' do
      it 'finds city with exact population' do
        expect(TurkishCities.find_by_population('exact', 15_840_900)).to eq %w[İstanbul]
      end
    end
  end

  describe '#find_by_postcode' do
    context 'when input is supported' do
      it 'finds city, district and subdistrict info of postcode' do
        expect(TurkishCities.find_by_postcode(34_380)).to eq %w[İstanbul Şişli Cumhuriyet]
      end
    end
  end
end
