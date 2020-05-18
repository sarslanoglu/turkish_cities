# frozen_string_literal: true

module DecomposerHelper
  def check_input_range(input, min, max)
    return if input.to_i.between?(min, max)

    raise RangeError, "Given value [#{input}] is outside bounds of #{min} to #{max}."
  end

  def city_not_found_error(input)
    "Couldn't find city name with '#{input}'"
  end

  def convert_chars(string)
    I18n.transliterate(string.downcase(:turkic))
  end

  def create_district_list(city_name)
    file_name = create_file_path(city_name)
    file_path = File.join(File.dirname(__FILE__), "../data/districts/#{file_name}.yaml")
    begin
      YAML.load_file(file_path)
    rescue Errno::ENOENT => e
      "Caught the exception: #{e}"
    end
  end

  def create_file_path(city_name)
    char_fallbacks = { 'ç' => 'c', 'ğ' => 'g', 'ı' => 'i', 'ö' => 'o', 'ş' => 's', 'ü' => 'u' }
    city_name.downcase(:turkic).encode('ASCII', 'UTF-8', fallback: char_fallbacks)
  end

  def district_not_found_error(district_input, city_input)
    "Couldn't find district name with '#{district_input}' of '#{city_input}'"
  end

  def postcode_not_found_error(postcode_input)
    "Couldn't find any subdistrict with postcode '#{postcode_input}'"
  end

  def prepare_city_list(city_list, options)
    if options.dig(:with)
      city_list.map do |city|
        result = {}
        result[:name] = city['name']

        add_plate_number_if_requested(result, city, options)
        add_phone_code_if_requested(result, city, options)
        add_metropolitan_municipality_if_requested(result, city, options)

        result[:region] = city['region'] if options.dig(:with, :region) || options.dig(:with, :all)
        result
      end
    else
      city_list.map do |city|
        city['name']
      end
    end
  end

  def sort_alphabetically(list, options = nil)
    turkish_alphabet = ' -0123456789abcçdefgğhıijklmnoöprsştuüvyz'
    list.sort_by do |item|
      item_to_sort = if options.nil? || options.dig(:with).nil?
                       item
                     else
                       item[:name]
                     end
      item_to_sort.downcase(:turkic).chars.map { |char| turkish_alphabet.index(char) }
    end
  end

  private

  def add_plate_number_if_requested(result, city, options = nil)
    return unless options.dig(:with, :plate_number) || options.dig(:with, :all)

    result[:plate_number] = city['plate_number']
  end

  def add_phone_code_if_requested(result, city, options = nil)
    return unless options.dig(:with, :phone_code) || options.dig(:with, :all)

    result[:phone_code] = city['phone_code']
  end

  def add_metropolitan_municipality_if_requested(result, city, options = nil)
    return unless options.dig(:with, :metropolitan_municipality_since) || options.dig(:with, :all)

    result[:metropolitan_municipality_since] = city['metropolitan_municipality_since']
  end
end
