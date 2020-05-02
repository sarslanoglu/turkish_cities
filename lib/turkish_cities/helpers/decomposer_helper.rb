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

  def create_file_path(city_name)
    char_fallbacks = { 'ç' => 'c', 'ğ' => 'g', 'ı' => 'i', 'ö' => 'o', 'ş' => 's', 'ü' => 'u' }
    city_name.downcase(:turkic).encode('ASCII', 'UTF-8', fallback: char_fallbacks)
  end

  def district_not_found_error(district_input, city_input)
    "Couldn't find district name with '#{district_input}' of '#{city_input}'"
  end

  def sort_alphabetically(list)
    turkish_alphabet = ' -abcçdefgğhıijklmnoöprsştuüvyz'
    list.sort_by do |item|
      item.downcase(:turkic).chars.map { |char| turkish_alphabet.index(char) }
    end
  end
end
