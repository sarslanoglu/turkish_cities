# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class City
  include DecomposerHelper

  I18n.enforce_available_locales = false

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)

  def find_by_id(plate_number)
    check_input_range(plate_number, 1, 81)

    CITY_LIST.each do |city|
      return city['name'] if city['plate_number'] == plate_number.to_i
    end
  end

  def find_by_phone_code(phone_code)
    check_input_range(phone_code, 212, 488)
    check_phone_code(phone_code)

    CITY_LIST.each do |city|
      case city['phone_code']
      when Array
        return city['name'] if city['phone_code'].include?(phone_code.to_i)
      when phone_code.to_i
        return city['name']
      end
    end
    city_not_found_error(phone_code)
  end

  def find_by_name(city_name, return_type)
    CITY_LIST.each do |city|
      if convert_chars(city['name']) == convert_chars(city_name)
        return return_type == 'plate_number' ? city['plate_number'] : city['phone_code']
      end
    end
    city_not_found_error(city_name)
  end

  def list_cities(options)
    city_list = CITY_LIST

    city_list = filter_metropolitan_municipalities(city_list) if options[:metropolitan_municipality]
    city_list = filter_regions(city_list, options[:region]) if options[:region]

    final_list = prepare_city_list(city_list, options)
    options[:alphabetically_sorted] ? sort_alphabetically(final_list, options) : final_list
  end

  def list_districts(city_name)
    CITY_LIST.each do |city|
      return city['districts'] if convert_chars(city['name']) == convert_chars(city_name)
    end
    city_not_found_error(city_name)
  end

  private

  def check_phone_code(input)
    return if input.to_i.even?

    raise ArgumentError, "Given value [#{input}] must be an even number."
  end

  def filter_metropolitan_municipalities(city_list)
    city_list.map { |city| city unless city['metropolitan_municipality_since'].nil? }.compact
  end

  def filter_regions(city_list, region)
    region = convert_chars(region.to_s)
    city_list.map { |city| city if convert_chars(city['region']) == region }.compact
  end
end
