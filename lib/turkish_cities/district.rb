# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class District
  include DecomposerHelper

  def initialize(city_name, district_name)
    @city_name = city_name
    @district_name = district_name
    @district_list = create_district_list(city_name)
  end

  def subdistricts
    return district_not_found_error(@district_name, @city_name) if district_item.nil?

    subdistricts = []
    district_item.each { |subdistrict| subdistricts << subdistrict[0] }

    sort_alphabetically(subdistricts)
  end

  def neighborhoods(subdistrict_name)
    return district_not_found_error(@district_name, @city_name) if district_item.nil?

    neighborhoods = create_neighborhoods(subdistrict_name)
    neighborhoods.is_a?(Array) ? sort_alphabetically(neighborhoods) : neighborhoods
  end

  private

  def create_neighborhoods(subdistrict_name)
    return create_neighborhoods_without_subdistrict_name if subdistrict_name.nil?

    if district_item[subdistrict_name].nil?
      return subdistrict_not_found_error(subdistrict_name, @district_name, @city_name)
    end

    create_neighborhoods_with_subdistrict_name(subdistrict_name)
  end

  def create_neighborhoods_without_subdistrict_name
    neighborhoods = []
    district_item.each do |subdistrict|
      subdistrict[1]['neighborhoods'].each { |neighborhood| neighborhoods << neighborhood }
    end
    neighborhoods
  end

  def create_neighborhoods_with_subdistrict_name(subdistrict_name)
    neighborhoods = []
    district_item[subdistrict_name]['neighborhoods'].each do |neighborhood|
      neighborhoods << neighborhood
    end
    neighborhoods
  end

  def district_item
    @district_list[@district_name]
  end
end
