# frozen_string_literal: true

require 'csv'
require 'yaml'

require_relative '../helpers/decomposer_helper'

module NeighborhoodsParser
  include DecomposerHelper

  district_hash = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
  mahalle_array = []
  last_city = 'Adana'
  last_district = ''
  last_subdistrict = ''
  last_postcode = 1720

  # rubocop:disable Metrics/BlockLength
  CSV.parse(File.read('ptt_list.csv'), headers: true).each do |row|
    data_array = row['il;ilçe;semt_bucak_belde;Mahalle;PK'].split(';')

    if data_array[0].downcase(:turkic).strip.capitalize(:turkic) != last_city ||
       data_array[4].to_i != last_postcode
      district_hash[last_district][last_subdistrict]['postcode'] = last_postcode
      district_hash[last_district][last_subdistrict]['neighborhoods'] = mahalle_array
      mahalle_array = []
      if data_array[0].downcase(:turkic).strip.capitalize(:turkic) != last_city
        file_name = create_file_path(last_city)
        File.write("#{file_name}.yaml", district_hash.to_yaml)
        district_hash = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
      end
    end

    mahalle = []
    data_array[3].downcase(:turkic).strip.split.each do |word|
      if word[0] == '('
        word[1] = word[1].capitalize!(:turkic) unless word[1].to_i.to_s == word[1]
      else
        word.capitalize!(:turkic)
      end
      mahalle << word
    end

    mahalle_array << mahalle.join(' ')

    last_city = data_array[0].downcase(:turkic).strip.capitalize(:turkic)
    last_district = data_array[1].downcase(:turkic).strip.capitalize(:turkic)
    last_subdistrict = data_array[2].downcase(:turkic).strip.capitalize(:turkic)
    last_postcode = data_array[4].to_i
  end
  # rubocop:enable Metrics/BlockLength
end
