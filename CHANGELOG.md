# Changelog

## 0.2.0 (2020-05-18)

### New features

* [#36](https://github.com/sarslanoglu/turkish_cities/issues/36): Add ```postcode``` class and ```find_by_postcode``` method for finding city, district and subdistrict information by given postcode

* [#33](https://github.com/sarslanoglu/turkish_cities/issues/33): Add ```list_neighborhoods``` method for listing neighborhoods and fix some wrong district names

* [#29](https://github.com/sarslanoglu/turkish_cities/issues/29): Add ```district``` class and ```list_subdistricts``` method for listing subdistricts

* [#27](https://github.com/sarslanoglu/turkish_cities/issues/27): Add all subdistricts and neighborhoods of all Turkish cities

* [#25](https://github.com/sarslanoglu/turkish_cities/issues/25): Add district data to each city at yaml file and add new method ```list_districts``` for listing disctricts of cities alphabetically sorted

### Changes

* [#24](https://github.com/sarslanoglu/turkish_cities/issues/24): Add listing support with ```metropolitan_municipality_since, phone_code, plate_number, region``` to ```listing_cities``` method

## 0.1.3 (2020-04-20)

### New features

* [#22](https://github.com/sarslanoglu/turkish_cities/issues/22): Add region data to cities.yaml and update ```list_cities``` method to support regions
* [#20](https://github.com/sarslanoglu/turkish_cities/issues/20): Add city finding with phone code and vice versa. ```find_name_by_phone_code``` and ```find_phone_code_by_name``` methods are added

### Bug fixes

* [#18](https://github.com/sarslanoglu/turkish_cities/issues/18): Fix yaml file read error while deploying apps to Heroku

## 0.1.2 (2020-04-13)

### New features

* [#3](https://github.com/sarslanoglu/turkish_cities/issues/3): Change city_list data to yaml file format

### Bug fixes

* [#2](https://github.com/sarslanoglu/turkish_cities/issues/2): Fix capital Turkish characters bug on cities with capital 'I' letter

### Changes

* [#15](https://github.com/sarslanoglu/turkish_cities/issues/15): Handle error messages at ```find_name_by_plate_number``` and ```find_plate_number_by_name``` methods

## 0.1.1 (2020-03-31)

### Changes

* Fix homepage problem on .gemspec file
