# frozen_string_literal: true

require_relative '../lib/turkish_cities'

RSpec.describe TurkishCities do
  it 'finds city by plate number' do
    expect(TurkishCities.find_name_by_plate_number(6)).to eq 'Ankara'
    expect(TurkishCities.find_name_by_plate_number(0o07)).to eq 'Antalya'
    expect(TurkishCities.find_name_by_plate_number(26)).to eq 'Eskişehir'
    expect(TurkishCities.find_name_by_plate_number(43.0)).to eq 'Kütahya'
    expect(TurkishCities.find_name_by_plate_number('78')).to eq 'Karabük'
  end

  it 'gives error when range is out of bounds' do
    expect { TurkishCities.find_name_by_plate_number(0) }
      .to raise_error(RangeError, 'Given value [0] is outside bounds of 1 to 81.')
    expect { TurkishCities.find_name_by_plate_number('1000') }
      .to raise_error(RangeError, 'Given value [1000] is outside bounds of 1 to 81.')
  end

  it 'finds plate number by city' do
    expect(TurkishCities.find_plate_number_by_name('Ankara')).to eq 6
    expect(TurkishCities.find_plate_number_by_name('Canakkale')).to eq 17
    expect(TurkishCities.find_plate_number_by_name('Eskişehir')).to eq 26
    expect(TurkishCities.find_plate_number_by_name('Isparta')).to eq 32
    expect(TurkishCities.find_plate_number_by_name('Istanbul')).to eq 34
    expect(TurkishCities.find_plate_number_by_name('kirsehir')).to eq 40
    expect(TurkishCities.find_plate_number_by_name('falansehir'))
      .to eq "Couldn't find city name with 'falansehir'"
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

  it 'lists only metropolitan municipality cities by alphabetical order' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true,
                                             metropolitan_municipality: true })
    expect(city_array.size).to eq 30
    expect(city_array[14]).to eq 'Kahramanmaraş'
  end
end
