# 🏙️ Turkish Cities
[![Gem Version](https://badge.fury.io/rb/turkish_cities.svg)](https://rubygems.org/gems/turkish_cities)
[![Build Status](https://travis-ci.org/sarslanoglu/turkish_cities.svg?branch=master)](https://travis-ci.org/sarslanoglu/turkish_cities)
[![Code Climate](https://codeclimate.com/github/sarslanoglu/turkish_cities.svg)](https://codeclimate.com/github/sarslanoglu/turkish_cities)
[![Coverage Status](https://coveralls.io/repos/github/sarslanoglu/turkish_cities/badge.svg?branch=master)](https://coveralls.io/github/sarslanoglu/turkish_cities?branch=master)
[![Protected by Hound](https://img.shields.io/badge/Protected_by-Hound-a873d1.svg)](https://houndci.com)
[![License](https://img.shields.io/github/license/sarslanoglu/turkish_cities.svg)](https://opensource.org/licenses/MIT)

**turkish_cities** is a Ruby gem which makes searching and listing Turkish cities easy. https://rubygems.org/gems/turkish_cities

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

There are 81 cities in Turkey. By calling a plate number between 1-81 will give city_name

```ruby
TurkishCities.find_name_by_plate_number(26) # => "Eskişehir"
TurkishCities.find_name_by_plate_number(7) # => "Antalya"
TurkishCities.find_name_by_plate_number(0007) # => "Antalya"
TurkishCities.find_name_by_plate_number(43.0) # => "Kütahya"
TurkishCities.find_name_by_plate_number('78') # => "Karabük"
TurkishCities.find_name_by_plate_number(100) # => 'Given value [100] is outside bounds of 1 to 81.'
```

### Finding plate number by city name

City name can be given case and turkish character insensitive

```ruby
TurkishCities.find_plate_number_by_name('Ankara') # => 6
TurkishCities.find_plate_number_by_name('Eskişehir') # => 26
TurkishCities.find_plate_number_by_name('Canakkale') # => 17
TurkishCities.find_plate_number_by_name('kirsehir') # => 40
TurkishCities.find_plate_number_by_name('falansehir') # => "Couldn't find city name with 'falansehir'"
```

### Listing all cities

By default cities will be listed by their plate number ascending.

```ruby
TurkishCities.list_cities # => ["Adana", "Adıyaman" ... "Kilis", "Osmaniye", "Düzce"]
```

While listing cities two additional parameters can be send ```alphabetically_sorted``` and ```metropolitan_municipality``` Both parameters can be send seperately and together.

```ruby
TurkishCities.list_cities({ alphabetically_sorted: true })
# => ["Adana", "Adıyaman" ... "Yalova", "Yozgat", "Zonguldak"]
TurkishCities.list_cities({ metropolitan_municipality: true })
# => ["Adana", "Ankara" ... "Trabzon", "Şanlıurfa", "Van"]
TurkishCities.list_cities({ alphabetically_sorted: true, metropolitan_municipality: true })
# => ["Adana", "Ankara" ... "Tekirdağ", "Trabzon", "Van"]
```

## Compatibility

- ✅ `2.7.0` (stable)
- ✅ `2.6.3` (stable)
- ✅ `2.5.5` (stable)

- This gem heavily depends of ```:turkic``` case mapping support of Ruby string downcase method. Below Ruby version 2.5.1 some functions will run buggy/false or even won't run at all.

## Contributing

1. Fork it ( https://github.com/sarslanoglu/turkish_cities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

turkish_cities changelog is available [here](CHANGELOG.md).

## Copyright

Copyright (c) 2020 Semih Arslanoglu. See [LICENSE.txt](LICENSE.txt) for
further details.
