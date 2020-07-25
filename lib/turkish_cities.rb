# frozen_string_literal: true

require_relative '../lib/turkish_cities/city'
require_relative '../lib/turkish_cities/district'
require_relative '../lib/turkish_cities/postcode'
require_relative '../lib/turkish_cities/version'

class TurkishCities
  def self.find_name_by_plate_number(plate_number)
    City.new.find_by_id(plate_number)
  end

  def self.find_name_by_phone_code(phone_code)
    City.new.find_by_phone_code(phone_code)
  end

  def self.find_plate_number_by_name(city_name)
    City.new.find_by_name(city_name, 'plate_number')
  end

  def self.find_phone_code_by_name(city_name)
    City.new.find_by_name(city_name, 'phone_code')
  end

  def self.list_cities(options = {})
    City.new.list_cities(options)
  end

  def self.list_districts(city_name)
    City.new.list_districts(city_name)
  end

  def self.list_subdistricts(city_name, district_name)
    District.new(city_name, district_name).list_subdistricts
  end

  def self.list_neighborhoods(city_name, district_name, subdistrict_name = nil)
    District.new(city_name, district_name).list_neighborhoods(subdistrict_name)
  end

  def self.find_by_postcode(postcode)
    Postcode.new.find_by_postcode(postcode)
  end
end
