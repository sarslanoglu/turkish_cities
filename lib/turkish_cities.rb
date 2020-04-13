# frozen_string_literal: true

require 'turkish_cities/city'
require 'turkish_cities/version'

class TurkishCities
  def self.find_name_by_plate_number(plate_number)
    City.new.find_by_id(plate_number)
  end

  def self.find_plate_number_by_name(city_name)
    City.new.find_by_name(city_name)
  end

  def self.list_cities(options = {})
    City.new.list_cities(options)
  end
end
