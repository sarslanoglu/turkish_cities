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
end
