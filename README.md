# 🏙️ Turkish Cities
[![Gem Version](https://badge.fury.io/rb/turkish_cities.svg)](https://rubygems.org/gems/turkish_cities)
[![Build Status](https://travis-ci.org/sarslanoglu/turkish_cities.svg?branch=master)](https://travis-ci.org/sarslanoglu/turkish_cities)
[![Coverage Status](https://coveralls.io/repos/github/sarslanoglu/turkish_cities/badge.svg?branch=master)](https://coveralls.io/github/sarslanoglu/turkish_cities?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/c1dbe0cef353b152956e/maintainability)](https://codeclimate.com/github/sarslanoglu/turkish_cities/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c1dbe0cef353b152956e/test_coverage)](https://codeclimate.com/github/sarslanoglu/turkish_cities/test_coverage)
[![Protected by Hound](https://img.shields.io/badge/Protected_by-Hound-a873d1.svg)](https://houndci.com)
[![License](https://img.shields.io/github/license/sarslanoglu/turkish_cities.svg)](https://opensource.org/licenses/MIT)

**turkish_cities** is a Ruby gem which makes searching and listing Turkish cities easy. https://rubygems.org/gems/turkish_cities

## Table of Contents
* [Installation](#installation)
* [Documentation](#documentation)
  * [Finding city name by plate number](#finding-city-name-by-plate-number)
  * [Finding city name by phone code](#finding-city-name-by-phone-code)
  * [Finding plate number by city name](#finding-plate-number-by-city-name)
  * [Listing all cities](#listing-all-cities)
  * [Listing all districts of given city](#listing-all-districts-of-given-city)
  * [Listing all subdistricts of given city and district](#listing-all-subdistricts-of-given-city-and-district)
* [Compatibility](#compatibility)
* [Contributing](#contributing)
* [Changelog](#changelog)
* [Copyright](#copyright)

## Installation

Installation is pretty standard:

```sh
$ gem install turkish_cities
```

or with using Bundler, add this line to your Gemfile

```rb
gem 'turkish_cities'
```

and run

```sh
$ bundle
```

## Documentation

With using irb just require gem and start using

```ruby
require 'turkish_cities'
```

### Finding city name by plate number

There are 81 cities in Turkey. By calling a plate number between 1-81 will give city_name.

```ruby
TurkishCities.find_name_by_plate_number(26) # => "Eskişehir"
TurkishCities.find_name_by_plate_number(7) # => "Antalya"
TurkishCities.find_name_by_plate_number(0007) # => "Antalya"
TurkishCities.find_name_by_plate_number(43.0) # => "Kütahya"
TurkishCities.find_name_by_plate_number('78') # => "Karabük"
TurkishCities.find_name_by_plate_number(100) # => 'Given value [100] is outside bounds of 1 to 81.'
```

### Finding city name by phone code

There are 81 cities in Turkey. By calling a phone code between 212-488 will give city_name. All phone codes are even sending odd number will give error without searching.

```ruby
TurkishCities.find_name_by_phone_code(312) # => "Ankara"
TurkishCities.find_name_by_phone_code(242) # => "Antalya"
TurkishCities.find_name_by_phone_code(000222) # => "Eskişehir"
TurkishCities.find_name_by_phone_code(274.0) # => "Kütahya"
TurkishCities.find_name_by_phone_code('212') # => "İstanbul"
TurkishCities.find_name_by_phone_code(216) # => "İstanbul"
TurkishCities.find_name_by_phone_code(360) # => 'Couldn't find city name with phone code 360'
TurkishCities.find_name_by_phone_code(0) # => 'Given value [0] is outside bounds of 212 to 488.'
TurkishCities.find_name_by_phone_code(213) # => 'Given value [213] must be an even number.'
```

### Finding plate number by city name

City name can be given case and turkish character insensitive.

```ruby
TurkishCities.find_plate_number_by_name('Ankara') # => 6
TurkishCities.find_plate_number_by_name('Eskişehir') # => 26
TurkishCities.find_plate_number_by_name('Canakkale') # => 17
TurkishCities.find_plate_number_by_name('Istanbul') # => 34
TurkishCities.find_plate_number_by_name('kirsehir') # => 40
TurkishCities.find_plate_number_by_name('falansehir') # => "Couldn't find city name with 'falansehir'"
```

### Finding phone number by city name

City name can be given case and turkish character insensitive.

```ruby
TurkishCities.find_phone_code_by_name('Ankara') # => 312
TurkishCities.find_phone_code_by_name('Eskişehir') # => 222
TurkishCities.find_phone_code_by_name('Canakkale') # => 286
TurkishCities.find_phone_code_by_name('Istanbul') # => [212, 216]
TurkishCities.find_phone_code_by_name('kirsehir') # => 386
TurkishCities.find_phone_code_by_name('filansehir') # => "Couldn't find city name with 'filansehir'"
```

### Listing all cities

By default cities will be listed by their plate number ascending.

```ruby
TurkishCities.list_cities # => ["Adana", "Adıyaman" ... "Kilis", "Osmaniye", "Düzce"]
```

While listing cities three additional parameters can be send ```alphabetically_sorted```, ```metropolitan_municipality``` and ```region```. All parameters can be send seperately and together.

```ruby
TurkishCities.list_cities({ alphabetically_sorted: true })
# => ["Adana", "Adıyaman" ... "Yalova", "Yozgat", "Zonguldak"]
TurkishCities.list_cities({ metropolitan_municipality: true })
# => ["Adana", "Ankara" ... "Trabzon", "Şanlıurfa", "Van"]
TurkishCities.list_cities({ region: 'Karadeniz' })
# => ["Amasya", "Artvin" ... "Bartın", "Karabük", "Düzce"]
TurkishCities.list_cities({ alphabetically_sorted: true, region: 'Karadeniz' })
# => ["Amasya", "Artvin" ... "Tokat", "Trabzon", "Zonguldak"]
TurkishCities.list_cities({ metropolitan_municipality: true, region: 'Karadeniz' })
# => ["Ordu", "Samsun", "Trabzon"]
TurkishCities.list_cities({ alphabetically_sorted: true, metropolitan_municipality: true })
# => ["Adana", "Ankara" ... "Tekirdağ", "Trabzon", "Van"]
```

### Listing all districts of given city

City name can be given case and turkish character insensitive. Listing of districts are alphabetically sorted.

```ruby
TurkishCities.list_districts('Ankara')
# => ["Akyurt", "Altındağ" ... "Sincan", "Şereflikoçhisar", "Yenimahalle"]
TurkishCities.list_districts('Eskişehir')
# => ["Alpu", "Beylikova", "Çifteler" ... "Sivrihisar", "Tepebaşı"]
TurkishCities.list_districts('Canakkale')
# => ["Ayvacık", "Bayramiç" ... "Lapseki", "Merkez", "Yenice"]
TurkishCities.list_districts('Bayburt')
# => ["Aydıntepe", "Demirözü", "Merkez"]
TurkishCities.list_districts('Istanbul').length
# => 39
TurkishCities.list_districts('filansehir')
# => "Couldn't find city name with 'filansehir'"
```

### Listing all subdistricts of given city and district

City name can be given case and turkish character insensitive. District name should be case and turkish character sensitive.(Correct district names can be obtained by ```list_districts``` method. Listing of subdistricts are alphabetically sorted.

```ruby
TurkishCities.list_subdistricts('Adana', 'Seyhan')
# => ["Akkapı", "Denizli" ... "Yeşiloba", "Yeşilyurt", "Ziyapaşa"]
TurkishCities.list_subdistricts('Eskişehir', 'Odunpazarı')
# => ["Alanönü", "Arifiye", "Büyükdere" ... "Vişnelik", "Yenikent"]
TurkishCities.list_subdistricts('Istanbul', 'Beşiktaş')
# => ["Abbasağa", "Akatlar", "Arnavutköy", "Bebek", "Etiler", "Gayrettepe", "Levazım", "Levent", "Ortaköy", "Türkali"]
TurkishCities.list_subdistricts('filansehir', 'Beşiktaş')
# => "Couldn't find district name with 'Beşiktaş' of 'filansehir'"
TurkishCities.list_subdistricts('İstanbul', 'Kadılarköyü')
# => "Couldn't find district name with 'Kadılarköyü' of 'İstanbul'"
```

## Compatibility

- ✅ `2.7.0` (stable)
- ✅ `2.6.3` (stable)
- ✅ `2.5.5` (stable)

- This gem heavily depends of ```:turkic``` case mapping support of Ruby string downcase method. Below Ruby version 2.5.1 some functions will run buggy/false or even won't run at all.

## Contributing

Contributing guidelines are available [here](CONTRIBUTING.md).

## Changelog

Changelog is available [here](CHANGELOG.md).

## Copyright

Copyright (c) 2020 Semih Arslanoglu. See [LICENSE.txt](LICENSE.txt) for
further details.
