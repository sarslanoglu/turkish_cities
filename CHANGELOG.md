# Changelog

## master (unreleased)

### New features

* [#23](https://github.com/sarslanoglu/turkish_cities/pull/23): Add region data to cities.yaml and update ```list_cities``` method to support regions
* [#21](https://github.com/sarslanoglu/turkish_cities/pull/21): Add city finding with phone code and vice versa. ```find_name_by_phone_code``` and ```find_phone_code_by_name``` methods are added

### Bug fixes

* [#19](https://github.com/sarslanoglu/turkish_cities/pull/19): Fix yaml file read error while deploying apps to Heroku

## 0.1.2 (2020-04-13)

### New features

* [#11](https://github.com/sarslanoglu/turkish_cities/pull/11): Change city_list data to yaml file format

### Bug fixes

* [#6](https://github.com/sarslanoglu/turkish_cities/pull/6): Fix capital Turkish characters bug on cities with capital 'I' letter

### Changes

* [#16](https://github.com/sarslanoglu/turkish_cities/pull/16): Handle error messages at ```find_name_by_plate_number``` and ```find_plate_number_by_name``` methods

## 0.1.1 (2020-03-31)

### Changes

* Fix homepage problem on .gemspec file
