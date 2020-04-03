# frozen_string_literal: true

require 'i18n'
require 'turkish_cities/data/city_list'

class City
  I18n.enforce_available_locales = false

  def find_by_id(plate_number)
    CITY_LIST[plate_number][:name]
  end

  def find_by_name(city_name)
    CITY_LIST.select do |key, hash|
      if convert_chars(hash[:name].downcase(:turkic)) == convert_chars(city_name.downcase)
        return key
      end
    end
  end

  def list_cities(options)
    city_list = ['-- select city --']
    CITY_LIST.each_value.select do |attributes|
      if options[:metropolitan_municipality]
        city_list.push(attributes[:name]) unless attributes[:metropolitan_municipality_since].nil?
      else
        city_list.push(attributes[:name])
      end
    end
    options[:alphabetically_sorted] ? sort_cities(city_list) : city_list
  end

  private

  def convert_chars(string)
    I18n.transliterate(string)
  end

  def sort_cities(city_list)
    turkish_alphabet = ' -abcçdefgğhıijklmnoöprsştuüvyz'
    city_list.sort_by do |city|
      city.downcase(:turkic).chars.map { |char| turkish_alphabet.index(char) }
    end
  end
end
