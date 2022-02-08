# ![TurkishCities](./public/assets/img/TurkishCities_yellow-on-darkblue_horizontal_914X343@3x-8.png)

<p align="center">
    <a href="https://rubygems.org/gems/turkish_cities">
        <img src="https://badge.fury.io/rb/turkish_cities.svg" alt="GemVersion"/></a>
    <a href="https://travis-ci.org/sarslanoglu/turkish_cities">
        <img src="https://travis-ci.org/sarslanoglu/turkish_cities.svg?branch=master" alt="BuildStatus"/></a>
    <a href="https://coveralls.io/github/sarslanoglu/turkish_cities?branch=master">
        <img src="https://coveralls.io/repos/github/sarslanoglu/turkish_cities/badge.svg?branch=master" alt="CoverageStatus"/></a>
    <a href="https://rubygems.org/gems/turkish_cities">
        <img src="https://img.shields.io/gem/dt/turkish_cities.svg" alt="DownloadCount"/></a>
    <a href="https://codeclimate.com/github/sarslanoglu/turkish_cities/maintainability">
        <img src="https://api.codeclimate.com/v1/badges/c1dbe0cef353b152956e/maintainability" alt="Maintainability"/></a>
    <a href="https://houndci.com">
        <img src="https://img.shields.io/badge/Protected_by-Hound-a873d1.svg" alt="Hound"/></a>
    <a href="https://opensource.org/licenses/MIT">
        <img src="https://img.shields.io/github/license/sarslanoglu/turkish_cities.svg" alt="License"/></a>
</p>

**Turkish Cities** is a Ruby gem which makes listing and finding Turkish cities easy. Search can be via name, post code, plate number, district name etc. Also calculate your travel distance and travel time between cities via distance methods.
https://rubygems.org/gems/turkish_cities

## Table of Contents
* [Installation](#installation)
* [Localization](#localization)
* [Documentation](#documentation)
  * [Finding city name by plate number](#finding-city-name-by-plate-number)
  * [Finding city name by phone code](#finding-city-name-by-phone-code)
  * [Finding plate number by city name](#finding-plate-number-by-city-name)
  * [Finding phone code by city name](#finding-phone-code-by-city-name)
  * [Listing all cities](#listing-all-cities)
    * [Listing all cities with only name](#listing-all-cities-with-only-name)
    * [Listing all cities with other parameters](#listing-all-cities-with-other-parameters)
  * [Listing all districts of given city](#listing-all-districts-of-given-city)
  * [Listing all subdistricts of given city and district](#listing-all-subdistricts-of-given-city-and-district)
  * [Listing all neighborhoods of given city and district](#listing-all-neighborhoods-of-given-city-and-district)
    * [With subdistrict info](#with-subdistrict-info)
    * [Without subdistrict info](#without-subdistrict-info)
  * [Finding city, district and subdistrict name by postcode](#finding-city-district-and-subdistrict-name-by-postcode)
  * [Finding city name with population data](#finding-city-name-with-population-data)
    * [Exact search](#exact-search)
    * [Below given](#below-given)
    * [Above given](#above-given)
    * [Between search](#between-search)
  * [Finding travel distance and time estimation between two cities](#finding-travel-distance-and-time-estimation-between-two-cities)
    * [By land](#by-land)
    * [By air](#by-air)
* [Data sources](#data-sources)
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

## Localization

Currently gem supports two different languages, Turkish and English. English is default, if no action taken.

Language can be easily changed by ```change_locale``` method. Valid parameters are 'tr' for Turkish and 'en' for English.

```rb
TurkishCities.change_locale('tr') # => "Dil Türkçe olarak ayarlandı."
```

After changing language all errors and result sets will be in desired language

```rb
TurkishCities.list_districts('Eskişehirrr') # => "'Eskişehirrr' ile bir şehir bulunamadı"
TurkishCities.distance_between('kirsehir', 'Ordu', 'land')
# => [533, "Kırşehir ile Ordu arasındaki karayolu mesafesi 533 km"]
```

## Documentation

With using irb just require gem and start using

```rb
require 'turkish_cities'
```

### Finding city name by plate number

There are 81 cities in Turkey. By calling a plate number between 1-81 will give city_name.

```rb
TurkishCities.find_name_by_plate_number(26)   # => "Eskişehir"
TurkishCities.find_name_by_plate_number(7)    # => "Antalya"
TurkishCities.find_name_by_plate_number(0007) # => "Antalya"
TurkishCities.find_name_by_plate_number(43.0) # => "Kütahya"
TurkishCities.find_name_by_plate_number('78') # => "Karabük"
TurkishCities.find_name_by_plate_number(100)  # => 'Given value [100] is outside bounds of 1 to 81.'
```

### Finding city name by phone code

There are 82 phone codes for each city in Turkey (Istanbul is an exception with different phone codes for Anatolian side and European side). By calling a phone code between 212-488 will give city_name. All phone codes ending with even numbers. So sending an odd number will give an error without searching.

```rb
TurkishCities.find_name_by_phone_code(312)    # => "Ankara"
TurkishCities.find_name_by_phone_code(242)    # => "Antalya"
TurkishCities.find_name_by_phone_code(000222) # => "Eskişehir"
TurkishCities.find_name_by_phone_code(274.0)  # => "Kütahya"
TurkishCities.find_name_by_phone_code('212')  # => "İstanbul"
TurkishCities.find_name_by_phone_code(216)    # => "İstanbul"
TurkishCities.find_name_by_phone_code(360)    # => 'Couldn't find city name with phone code 360'
TurkishCities.find_name_by_phone_code(0)      # => 'Given value [0] is outside bounds of 212 to 488.'
TurkishCities.find_name_by_phone_code(213)    # => 'Given value [213] must be an even number.'
```

### Finding plate number by city name

City name can be given case and turkish character insensitive.

```rb
TurkishCities.find_plate_number_by_name('Ankara')     # => 6
TurkishCities.find_plate_number_by_name('Eskişehir')  # => 26
TurkishCities.find_plate_number_by_name('Canakkale')  # => 17
TurkishCities.find_plate_number_by_name('Istanbul')   # => 34
TurkishCities.find_plate_number_by_name('kirsehir')   # => 40
TurkishCities.find_plate_number_by_name('falansehir') # => "Couldn't find city name with 'falansehir'"
```

### Finding phone code by city name

City name can be given case and turkish character insensitive.

```rb
TurkishCities.find_phone_code_by_name('Ankara')     # => 312
TurkishCities.find_phone_code_by_name('Eskişehir')  # => 222
TurkishCities.find_phone_code_by_name('Canakkale')  # => 286
TurkishCities.find_phone_code_by_name('Istanbul')   # => [212, 216]
TurkishCities.find_phone_code_by_name('kirsehir')   # => 386
TurkishCities.find_phone_code_by_name('filansehir') # => "Couldn't find city name with 'filansehir'"
```

### Listing all cities

By default cities will be listed by their plate number ascending.

```rb
TurkishCities.list_cities # => ["Adana", "Adıyaman" ... "Kilis", "Osmaniye", "Düzce"]
```

### Listing all cities with only name

While listing cities three additional parameters can be sent ```alphabetically_sorted```, ```metropolitan_municipality``` and ```region```. All parameters can be sent separately and together.

```rb
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

### Listing all cities with other parameters

While listing cities ```with``` parameter can be used for listing cities with other attributes. These parameters are ```alphabetically_sorted```, ```metropolitan_municipality``` and ```region```. All parameters can be sent separately and together.

```rb
TurkishCities.list_cities({ alphabetically_sorted: true, with: { phone_code: true } })
# => [{:name=>"Adana", :phone_code=>322}, {:name=>"Adıyaman", :phone_code=>416}, {:name=>"Afyon", :phone_code=>272} .
# .. {:name=>"Yozgat", :phone_code=>354}, {:name=>"Zonguldak", :phone_code=>372}]
TurkishCities.list_cities({ with: { plate_number: true } })
# => [{:name=>"Adana", :plate_number=>1}, {:name=>"Adıyaman", :plate_number=>2}, {:name=>"Afyon", :plate_number=>3} .
# .. {:name=>"Osmaniye", :plate_number=>80}, {:name=>"Düzce", :plate_number=>81}]
TurkishCities.list_cities({ metropolitan_municipality: true, region: 'Karadeniz', with: { all: true } })
# => [{:name=>"Ordu", :plate_number=>52, :phone_code=>452, :metropolitan_municipality_since=>2012,
#      :region=>"Karadeniz"},{:name=>"Samsun", :plate_number=>55, :phone_code=>362,
#      :metropolitan_municipality_since=>1993, :region=>"Karadeniz"}, {:name=>"Trabzon", :plate_number=>61,
#      :phone_code=>462, :metropolitan_municipality_since=>2012, :region=>"Karadeniz"}]
```

### Listing all districts of given city

City name can be given case and turkish character insensitive. Listing of districts are alphabetically sorted.

```rb
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

City name can be given case and turkish character insensitive. District name should be case and turkish character sensitive.(Correct district names can be obtained by ```list_districts``` method.) Listing of subdistricts are alphabetically sorted.

```rb
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

### Listing all neighborhoods of given city and district

### With subdistrict info

City name can be given case and turkish character insensitive. District name and subdistrict name should be case and turkish character sensitive.(Correct district names can be obtained by the ```list_districts``` method. Correct subdistrict names can be obtained by ```list_subdistricts``` method.) Listings of neighborhoods are alphabetically sorted.

```rb
TurkishCities.list_neighborhoods('Adana', 'Seyhan', 'Emek')
# => ["Emek Mah", "Ova Mah", "Şakirpaşa Mah", "Uçak Mah"]
TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı', 'Büyükdere')
# => ["Büyükdere Mah", "Göztepe Mah", "Gültepe Mah", "Yıldıztepe Mah"]
TurkishCities.list_neighborhoods('Istanbul', 'Beşiktaş', 'Gayrettepe')
# => ["Balmumcu Mah", "Dikilitaş Mah", "Gayrettepe Mah", "Yıldız Mah"]
TurkishCities.list_neighborhoods('Adana', 'Beşiktaş', 'Emek')
# => "Couldn't find district name with 'Beşiktaş' of 'Adana'"
TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı', 'Büyükkkkkdere')
# => "Couldn't find subdistrict with 'Büyükkkkkdere' of 'Odunpazarı'/'Eskişehir'"
```

### Without subdistrict info

Also ```list_neighborhoods``` can work without subdistrict information. This time neighborhoods result will be larger based on searched city and district.

City name can be given case and turkish character insensitive. District name should be case and turkish character sensitive.(Correct district names can be obtained by the ```list_districts``` method.) Listings of neighborhoods are alphabetically sorted.

```rb
TurkishCities.list_neighborhoods('Adana', 'Seyhan')
# => ["2000 Evler Mah", "Ahmet Remzi Yüreğir Mah", "Akkapı Mah" ... "Zeytinli Mah", "Ziyapaşa Mah"]
TurkishCities.list_neighborhoods('Eskişehir', 'Odunpazarı')
# => ["71 Evler Mah", "75. Yıl Osb Mah" ... "Yukarıkalabak Mah", "Yürükkaracaören Mah", "Yürükkırka Mah"]
TurkishCities.list_neighborhoods('Istanbul', 'Beşiktaş')
# => ["Abbasağa Mah", "Akat Mah", "Arnavutköy Mah" ... "Türkali Mah", "Ulus Mah", "Vişnezade Mah", "Yıldız Mah"]
TurkishCities.list_neighborhoods('İstanbul', 'filanmevki')
# => "Couldn't find district name with 'filanmevki' of 'İstanbul'"
```

### Finding city, district and subdistrict name by postcode

In Turkey postcodes are uniq for subdistricts. Basically when a postcode is search through ```find_by_postcode``` it will give city, district and subdistrict information of postcode if valid and found

```rb
TurkishCities.find_by_postcode(34380)    # => ["İstanbul", "Şişli", "Cumhuriyet"]
TurkishCities.find_by_postcode(34433)    # => ["İstanbul", "Beyoğlu", "Cihangir"]
TurkishCities.find_by_postcode('26040')  # => ["Eskişehir", "Odunpazarı", "Büyükdere"]
TurkishCities.find_by_postcode(34382)    # => "Couldn't find any subdistrict with postcode '34382'"
TurkishCities.find_by_postcode('100000') # => Given value [100000] is outside bounds of 1010 to 81952.
```

### Finding city name with population data

### Exact search

Search city name with exact population

```rb
TurkishCities.find_by_population('exact', 15840900)
# => ["İstanbul"]
TurkishCities.find_by_population('exact', 898369)
# => ["Eskişehir"]
TurkishCities.find_by_population('exact', 2130432)
# => ["Gaziantep"]
TurkishCities.find_by_population('exatc', 2130432)
# => "Population type 'exatc' is unsupported"
TurkishCities.find_by_population('exact', 10432)
# => Given value [10432] is outside bounds of 83645 to 15840900
TurkishCities.find_by_population('exact', 22130432)
# => Given value [22130432] is outside bounds of 83645 to 15840900
```

### Below given

Search city name with below population

```rb
TurkishCities.find_by_population('below', 86000)
# => ["Tunceli", "Bayburt"]
TurkishCities.find_by_population('below', 500000)
# => ["Amasya", "Artvin" ... "Kilis", "Düzce"]
TurkishCities.find_by_population('below', 5000000)
# => ["Adana", "Adıyaman" ... "Kilis", "Osmaniye", "Düzce"]
TurkishCities.find_by_population('woleb', 2130432)
# => "Population type 'woleb' is unsupported"
TurkishCities.find_by_population('below', 10432)
# => Given value [10432] is outside bounds of 83645 to 15840900
TurkishCities.find_by_population('below', 22130432)
# => Given value [22130432] is outside bounds of 83645 to 15840900
```

### Above given

Search city name with above population

```rb
TurkishCities.find_by_population('above', 860000)
# => ["Adana", "Ankara" ... "Şanlıurfa", "Van"]
TurkishCities.find_by_population('above', 2500000)
# => ["Ankara", "Antalya", "Bursa", "İstanbul", "İzmir"]
TurkishCities.find_by_population('above', 5000000)
# => ["Ankara", "İstanbul"]
TurkishCities.find_by_population('abov', 2130432)
# => "Population type 'abov' is unsupported"
TurkishCities.find_by_population('above', 10432)
# => Given value [10432] is outside bounds of 83645 to 15840900
TurkishCities.find_by_population('above', 22130432)
# => Given value [22130432] is outside bounds of 83645 to 15840900
```

### Between search

Search city name with between population

```rb
TurkishCities.find_by_population('between', 15840900, 3000000)
# => ["Ankara", "Bursa", "İzmir"]
TurkishCities.find_by_population('between', 828369, 985732)
# => ["Eskişehir", "Mardin"]
TurkishCities.find_by_population('between', 2130432, 3500000)
# => ["Adana", "Antalya", "Bursa", "Konya", "Şanlıurfa"]
TurkishCities.find_by_population('between', 10432, 100000)
# => Given value [10432] is outside bounds of 83645 to 15840900
TurkishCities.find_by_population('between', 22130432, 3400000)
# => Given value [22130432] is outside bounds of 83645 to 15840900
```

### Finding travel distance and time estimation between two cities

### By land

City names can be given case and turkish character insensitive. Travel method should be lower case. Array with 2 elements will be returned. First element is distance between cities in kilometers and the second element is the description created by the first element.

```rb
TurkishCities.distance_between('Eskişehir', 'Kastamonu', 'land')
# => [480, "Land travel distance between Eskişehir and Kastamonu is 480 km."]
TurkishCities.distance_between('kirsehir', 'Ordu', 'land')
# => [533, "Land travel distance between Kırşehir and Ordu is 533 km."]
TurkishCities.distance_between('İzmir', 'Antalya', 'land')
# => [444, "Land travel distance between İzmir and Antalya is 444 km."]
TurkishCities.distance_between('istanbul', 'kars', 'land')
# => [1427, "Land travel distance between İstanbul and Kars is 1427 km."]
TurkishCities.distance_between('Adana', 'Adıyaman', 'time')
# => "Travel method 'time' is unsupported"
TurkishCities.distance_between('filansa', 'falansa', 'land')
# => "Couldn't find cities combination with 'filansa/falansa'"
```

### By air

City names can be given case and turkish character insensitive. Travel method should be lower case. Array with 3 elements will be returned. First element is distance between cities in kilometers, the second element is estimated travel time and the last element is the description created by the first two elements.

```rb
TurkishCities.distance_between('Eskişehir', 'Kastamonu', 'air')
# => [327.74, 62, "Air travel distance between Eskişehir and Kastamonu is 327.74 km. Estimated air travel would take 62 minutes."]
TurkishCities.distance_between('kirsehir', 'Ordu', 'air')
# => [376.89, 67, "Air travel distance between Kırşehir and Ordu is 376.89 km. Estimated air travel would take 67 minutes."]
TurkishCities.distance_between('İzmir', 'Antalya', 'air')
# => [357.18, 65, "Air travel distance between İzmir and Antalya is 357.18 km. Estimated air travel would take 65 minutes."]
TurkishCities.distance_between('istanbul', 'kars', 'air')
# => [1187.94, 120, "Air travel distance between İstanbul and Kars is 1187.94 km. Estimated air travel would take 120 minutes."]
TurkishCities.distance_between('Adana', 'Adıyaman', 'time')
# => "Travel method 'time' is unsupported"
TurkishCities.distance_between('filansa', 'falansa', 'air')
# => "Couldn't find cities combination with 'filansa/falansa'"
```

## Data sources

All information related with cities can be found at:

```
https://tr.wikipedia.org/wiki/{#city_name_here}
```

Districts, subdisctricts, neighborhoods and postcodes can be found at:

```
https://postakodu.ptt.gov.tr/
```
All districts/subdistricts are up to date at: 23 January 2022 with using PTT file released at 22 November 2021

Land distance information can be found at:

```
https://www.kgm.gov.tr/SiteCollectionDocuments/KGMdocuments/Root/Uzakliklar/ilmesafe.xls
```

Statistics for gem can be found at:
```
https://bestgems.org/gems/turkish_cities
```

## Compatibility

| Ruby Version | Supported          |
| ------------ | ------------------ |
| 2.7.x        | :white_check_mark: |
| 2.6.x        | :white_check_mark: |
| 2.5.x        | :white_check_mark: |
| < 2.5.1      | :x:                |

- TurkishCities heavily depends on ```:turkic``` case mapping support of Ruby string downcase method. Below Ruby version 2.5.1 some functions will run buggy/false or even won't run at all.

## Roadmap

- Add missing sea travel method
- Refactor tests (separate test suites with more edge case tests)

## Contributing

Contributing guidelines are available [here](CONTRIBUTING.md).

People behind the 💻
<table>
  <tr>
    <td align="center"><a href="https://enderahmetyurt.com/"><img src="https://avatars2.githubusercontent.com/u/447588" width="100px;" alt=""/><br /><sub><b>Ender Ahmet Yurt</b></sub></a><br /></td>
    <td align="center"><a href="https://www.linkedin.com/in/serpilacar/"><img src="https://avatars0.githubusercontent.com/u/17191440" width="100px;" alt=""/><br /><sub><b>Serpil Acar</b></sub></a><br /></td>
    <td align="center"><a href="https://www.linkedin.com/in/semiharslanoglu/"><img src="https://avatars2.githubusercontent.com/u/10260283" width="100px;" alt=""/><br /><sub><b>Semih Arslanoğlu</b></sub></a><br /></td>
  </tr>
</table>

## Changelog

Changelog is available [here](CHANGELOG.md).

## Logo

TurkishCities's logo created by [Nebal Çolpan](https://www.behance.net/nebalcolpan). You can find the logo in various
formats [here](https://github.com/sarslanoglu/turkish_cities/tree/master/public/assets/img/).

The logo is licensed under a
[Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/deed.en_GB).

## Copyright

Copyright (c) 2020 Semih Arslanoglu. See [LICENSE.txt](LICENSE.txt) for
further details.
