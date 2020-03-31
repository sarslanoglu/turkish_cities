# 🏙️ Turkish Cities

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

```ruby
require 'turkish_cities'
```

### Finding city name by plate number

There are 81 cities in Turkey. By calling a plate number between 1-81 will give city_name

```ruby
TurkishCities.find_name_by_plate_number(26) # => "Eskişehir"
TurkishCities.find_name_by_plate_number(7) # => "Antalya"
TurkishCities.find_name_by_plate_number(0007) # => "Antalya"
```

### Finding plate number by city name

City name can be given case and turkish character insensitive

```ruby
TurkishCities.find_plate_number_by_name('Ankara') # => 6
TurkishCities.find_plate_number_by_name('Eskişehir') # => 26
TurkishCities.find_plate_number_by_name('Canakkale') # => 17
TurkishCities.find_plate_number_by_name('kirsehir') # => 40
```

### Listing all cities

By default cities will be listed by their plate number ascending.

```ruby
TurkishCities.list_cities # => [ "-- select city --", "Adana", "Adıyaman" ... "Kilis", "Osmaniye", "Düzce"]
```

While listing cities two additional parameters can be send ```alphabetically_sorted``` and ```metropolitan_municipality``` Both parameters can be send seperately and together.

```ruby
TurkishCities.list_cities({ alphabetically_sorted: true })
# => [ "-- select city --", "Adana", "Adıyaman" ... "Yalova", "Yozgat", "Zonguldak"]
TurkishCities.list_cities({ metropolitan_municipality: true })
# => [ "-- select city --", "Adana", "Ankara" ... "Trabzon", "Şanlıurfa", "Van"]
TurkishCities.list_cities({ alphabetically_sorted: true, metropolitan_municipality: true })
# => [ "-- select city --", "Adana", "Ankara" ... "Tekirdağ", "Trabzon", "Van"]
```

## Compatibility

This gem is written with Ruby 2.7.0
Additional compatibility tests will conduct in future releases

## Contributing

1. Fork it ( https://github.com/[my-github-username]/turkish_cities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

turkish_cities is licensed under MIT. See [LICENSE](LICENSE.txt).

