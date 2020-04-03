# frozen_string_literal: true

require_relative '../lib/turkish_cities'

RSpec.describe TurkishCities do
  it 'finds city by plate number' do
    expect(TurkishCities.find_name_by_plate_number(6)).to eq 'Ankara'
    expect(TurkishCities.find_name_by_plate_number(0o07)).to eq 'Antalya'
    expect(TurkishCities.find_name_by_plate_number(26)).to eq 'Eskişehir'
  end

  it 'finds plate number by city' do
    expect(TurkishCities.find_plate_number_by_name('Ankara')).to eq 6
    expect(TurkishCities.find_plate_number_by_name('Canakkale')).to eq 17
    expect(TurkishCities.find_plate_number_by_name('Eskişehir')).to eq 26
    expect(TurkishCities.find_plate_number_by_name('Isparta')).to eq 32
    expect(TurkishCities.find_plate_number_by_name('Istanbul')).to eq 34
    expect(TurkishCities.find_plate_number_by_name('kirsehir')).to eq 40
  end

  it 'lists cities by plate number' do
    city_array = TurkishCities.list_cities
    expect(city_array[42]).to eq 'Konya'
  end

  it 'lists cities by alphabetical order' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true })
    expect(city_array[40]).to eq 'İstanbul'
  end

  it 'lists only metropolitan municipality cities by plate number' do
    city_array = TurkishCities.list_cities({ metropolitan_municipality: true })
    expect(city_array.size).to eq 31
    expect(city_array[15]).to eq 'İzmir'
  end

  it 'lists only metropolitan municipality cities by alphabetical order' do
    city_array = TurkishCities.list_cities({ alphabetically_sorted: true,
                                             metropolitan_municipality: true })
    expect(city_array.size).to eq 31
    expect(city_array[15]).to eq 'Kahramanmaraş'
  end
end
