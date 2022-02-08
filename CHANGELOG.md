# Changelog

## 0.6.0 (Unreleased)

### New features

* [#12](https://github.com/sarslanoglu/turkish_cities/issues/12): Add city population data and ```find_by_population``` method

### Changes

* [#103](https://github.com/sarslanoglu/turkish_cities/issues/103): Update city/district/subdistrict informations to 2022

## 0.5.0 (2021-06-06)

### New features

* [#68](https://github.com/sarslanoglu/turkish_cities/issues/68): Add localization for all method responses and errors

## 0.4.0 (2021-04-25)

### New features

* [#66](https://github.com/sarslanoglu/turkish_cities/issues/66): Add ```distance_between_land``` method for calculating land travel distances between cities

## 0.3.0 (2020-11-22)

### New features

* [#13](https://github.com/sarslanoglu/turkish_cities/issues/13): Add ```distance``` class and ```distance_between``` method for calculating air travel distance and time estimation between cities

### Changes

* [#50](https://github.com/sarslanoglu/turkish_cities/issues/50): Additional improvements on `District` class methods

* [#45](https://github.com/sarslanoglu/turkish_cities/issues/45): Refactor `District` class

## 0.2.1 (2020-06-29)

### Bug fixes

* [#38](https://github.com/sarslanoglu/turkish_cities/issues/38): ```NoMethodError``` on ```list_neighborhoods``` when called with wrong subdistrict name

### Changes

* [#39](https://github.com/sarslanoglu/turkish_cities/issues/39): May maintenance of gem - 2020-05-24

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
