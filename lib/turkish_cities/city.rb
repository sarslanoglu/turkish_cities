# frozen_string_literal: true

require 'i18n'
require 'yaml'

class City
  I18n.enforce_available_locales = false

  CITY_LIST = YAML.load_file('lib/turkish_cities/data/cities.yaml')

  def find_by_id(plate_number)
    CITY_LIST.each do |city|
      return city['name'] if city['plate_number'] == plate_number.to_i
    end
  end

  def find_by_name(city_name)
    CITY_LIST.each do |city|
      if convert_chars(city['name'].downcase(:turkic)) == convert_chars(city_name.downcase(:turkic))
        return city['plate_number']
      end
    end
  end

  def list_cities(options)
    if options[:metropolitan_municipality]
      city_list = CITY_LIST.map do |city|
        city unless city['metropolitan_municipality_since'].nil?
      end
      city_list
    else
      city_list = CITY_LIST
    end

    final_city_list = prepare_city_list(city_list.compact)
    options[:alphabetically_sorted] ? sort_cities(final_city_list) : final_city_list
  end

  private

  def convert_chars(string)
    I18n.transliterate(string)
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
