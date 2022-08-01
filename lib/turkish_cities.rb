# frozen_string_literal: true

require_relative '../lib/turkish_cities/city'
require_relative '../lib/turkish_cities/distance'
require_relative '../lib/turkish_cities/district'
require_relative '../lib/turkish_cities/elevation'
require_relative '../lib/turkish_cities/population'
require_relative '../lib/turkish_cities/postcode'
require_relative '../lib/turkish_cities/version'

require 'i18n'

I18n.load_path << "#{File.expand_path('config/locales')}/en.yml"
I18n.load_path << "#{File.expand_path('config/locales')}/tr.yml"

class TurkishCities
  PLATE_NUMBER = 'plate_number'
  PHONE_CODE = 'phone_code'

  def self.change_locale(language_code)
    if %w[en tr].include?(language_code)
      I18n.locale = language_code.to_sym
      return I18n.t('language.success')
    end
    I18n.t('language.errors.unsupported_language_code')
  end

  def self.find_name_by_plate_number(plate_number)
    City.new.find_by_id(plate_number)
  end

  def self.find_name_by_phone_code(phone_code)
    City.new.find_by_phone_code(phone_code)
  end

  def self.find_plate_number_by_name(city_name)
    City.new.find_by_name(city_name, self::PLATE_NUMBER)
  end

  def self.find_phone_code_by_name(city_name)
    City.new.find_by_name(city_name, self::PHONE_CODE)
  end

  def self.list_cities(options = {})
    City.new.list_cities(options)
  end

  def self.list_districts(city_name)
    City.new.list_districts(city_name)
  end

  def self.distance_between(from, to, travel_method)
    Distance.new(from, to, travel_method).distance_between
  end

  def self.list_subdistricts(city_name, district_name)
    District.new(city_name, district_name).subdistricts
  end

  def self.list_neighborhoods(city_name, district_name, subdistrict_name = nil)
    District.new(city_name, district_name).neighborhoods(subdistrict_name)
  end

  def self.find_by_elevation(type, elevation_one, elevation_two = nil)
    Elevation.new.find_by_elevation(type, elevation_one, elevation_two)
  end

  def self.find_by_population(type, population_one, population_two = nil)
    Population.new.find_by_population(type, population_one, population_two)
  end

  def self.find_by_postcode(postcode)
    Postcode.new.find_by_postcode(postcode)
  end
end
