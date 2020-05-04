# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class District
  include DecomposerHelper

  def list_subdistricts(city_name, district_name)
    district_list = create_district_list(city_name)

    if !district_list[district_name].nil?
      subdistricts = []
      district_list[district_name].each do |subdistrict|
        subdistricts << subdistrict[0]
      end
      sort_alphabetically(subdistricts)
    else
      district_not_found_error(district_name, city_name)
    end
  end

  private

  def create_district_list(city_name)
    file_name = create_file_path(city_name)
    file_path = File.join(File.dirname(__FILE__), "data/districts/#{file_name}.yaml")
    begin
      YAML.load_file(file_path)
    rescue Errno::ENOENT => e
      "Caught the exception: #{e}"
    end
  end
end
