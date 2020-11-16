# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class Postcode
  include DecomposerHelper

  def find_by_postcode(postcode)
    check_input_range(postcode, 1010, 81_952)

    city_name = City.new.find_by_id(postcode.to_i / 1000)
    city_file = create_district_list(city_name)

    city_file.each do |district|
      district_name = district[0]
      district[1].each do |subdistrict|
        return [city_name, district_name, subdistrict[0]] if subdistrict[1]['postcode'] == postcode.to_i
      end
    end
    postcode_not_found_error(postcode)
  end
end
