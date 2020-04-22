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

  it 'gives error when plate number range is out of bounds' do
    expect { TurkishCities.find_name_by_plate_number(nil) }
      .to raise_error(RangeError, 'Given value [] is outside bounds of 1 to 81.')
    expect { TurkishCities.find_name_by_plate_number(0) }
      .to raise_error(RangeError, 'Given value [0] is outside bounds of 1 to 81.')
    expect { TurkishCities.find_name_by_plate_number('1000') }
      .to raise_error(RangeError, 'Given value [1000] is outside bounds of 1 to 81.')
  end

  it 'finds city by phone code' do
    expect(TurkishCities.find_name_by_phone_code(312)).to eq 'Ankara'
    expect(TurkishCities.find_name_by_phone_code(242)).to eq 'Antalya'
    expect(TurkishCities.find_name_by_phone_code(222)).to eq 'Eskişehir'
    expect(TurkishCities.find_name_by_phone_code(274)).to eq 'Kütahya'
    expect(TurkishCities.find_name_by_phone_code(212)).to eq 'İstanbul'
    expect(TurkishCities.find_name_by_phone_code(216)).to eq 'İstanbul'
    expect(TurkishCities.find_name_by_phone_code(370)).to eq 'Karabük'
    expect(TurkishCities.find_name_by_phone_code(360))
      .to eq "Couldn't find city name with phone code 360"
  end

  it 'gives error when phone code range is out of bounds' do
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

  it 'finds phone code by city' do
    expect(TurkishCities.find_phone_code_by_name('Ankara')).to eq 312
    expect(TurkishCities.find_phone_code_by_name('Canakkale')).to eq 286
    expect(TurkishCities.find_phone_code_by_name('Eskişehir')).to eq 222
    expect(TurkishCities.find_phone_code_by_name('Isparta')).to eq 246
    expect(TurkishCities.find_phone_code_by_name('Istanbul')).to eq [212, 216]
    expect(TurkishCities.find_phone_code_by_name('kirsehir')).to eq 386
    expect(TurkishCities.find_phone_code_by_name('filansehir'))
      .to eq "Couldn't find city name with 'filansehir'"
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
end
