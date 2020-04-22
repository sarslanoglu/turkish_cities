# frozen_string_literal: true

require 'i18n'
require 'yaml'

class City
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
      if city['phone_code'].is_a?(Array)
        return city['name'] if city['phone_code'].include?(phone_code.to_i)
      elsif city['phone_code'] == phone_code.to_i
        return city['name']
      end
    end
    "Couldn't find city name with phone code #{phone_code}"
  end

  def find_by_name(city_name, return_type)
    CITY_LIST.each do |city|
      if convert_chars(city['name']) == convert_chars(city_name)
        return return_type == 'plate_number' ? city['plate_number'] : city['phone_code']
      end
    end
    "Couldn't find city name with '#{city_name}'"
  end

  def list_cities(options)
    city_list = CITY_LIST

    city_list = filter_metropolitan_municipalities(city_list) if options[:metropolitan_municipality]
    city_list = filter_regions(city_list, options[:region]) if options[:region]

    final_city_list = prepare_city_list(city_list)
    options[:alphabetically_sorted] ? sort_cities(final_city_list) : final_city_list
  end

  def list_districts(city_name)
    CITY_LIST.each do |city|
      return city['districts'] if convert_chars(city['name']) == convert_chars(city_name)
    end
    "Couldn't find city name with '#{city_name}'"
  end

  private

  def check_input_range(input, min, max)
    return if input.to_i.between?(min, max)

    raise RangeError, "Given value [#{input}] is outside bounds of #{min} to #{max}."
  end

  def check_phone_code(input)
    return if input.to_i.even?

    raise ArgumentError, "Given value [#{input}] must be an even number."
  end

  def convert_chars(string)
    I18n.transliterate(string.downcase(:turkic))
  end

  def filter_metropolitan_municipalities(city_list)
    city_list.map { |city| city unless city['metropolitan_municipality_since'].nil? }.compact
  end

  def filter_regions(city_list, region)
    region = convert_chars(region.to_s)
    city_list.map { |city| city if convert_chars(city['region']) == region }.compact
  end

  def prepare_city_list(city_list)
    city_list.map do |city|
      city['name']
    end
  end

  def sort_cities(city_list)
    turkish_alphabet = ' -abcçdefgğhıijklmnoöprsştuüvyz'
    city_list.sort_by do |city|
      city.downcase(:turkic).chars.map { |char| turkish_alphabet.index(char) }
    end
  end
end
