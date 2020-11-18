# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class Distance
  include DecomposerHelper

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)
  RADIUS_OF_EARTH = 6371 # Earth radius in km is 6371

  def initialize(from, to, travel_method)
    @from = from
    @to = to
    @travel_method = travel_method
  end

  def distance_between
    case @travel_method
    when 'land'
      distance_between_land
    when 'sea'
      distance_between_sea
    when 'air'
      distance_between_air
    else
      unsupported_travel_method(@travel_method)
    end
  end

  private

  def distance_between_land
    # TODO
  end

  def distance_between_sea
    # TODO
  end

  def distance_between_air
    city_array = find_city_attributes
    case city_array
    when String
      city_array
    when Array
      results = []
      results[0] = calculate_flight_distance(city_array).round(2)
      results[1] = distance_time_estimation(results[0]).to_i
      results[2] = description_text('Air', city_array, results)
      results
    end
  end

  def find_city_attributes
    from_city = to_city = nil

    CITY_LIST.each do |city|
      from_city = city if convert_chars(@from) == convert_chars(city['name'])
      to_city = city if convert_chars(@to) == convert_chars(city['name'])
    end

    from_city.nil? || to_city.nil? ? cities_not_found_error(@from, @to) : [from_city, to_city]
  end

  def degree_to_radian(degree)
    degree * Math::PI / 180
  end

  # rubocop:disable Metrics/AbcSize
  def calculate_flight_distance(city_array)
    lat_diff = degree_to_radian(city_array[1]['latitude'] - city_array[0]['latitude'])
    lng_diff = degree_to_radian(city_array[1]['longitude'] - city_array[0]['longitude'])

    from_lat = degree_to_radian(city_array[0]['latitude'])
    to_lat = degree_to_radian(city_array[1]['latitude'])

    cosines_var = (Math.sin(lat_diff / 2)**2) + ((Math.sin(lng_diff / 2)**2) * (Math.cos(from_lat) * Math.cos(to_lat)))
    result = 2 * Math.atan2(Math.sqrt(cosines_var), Math.sqrt(1 - cosines_var))
    RADIUS_OF_EARTH * result
  end
  # rubocop:enable Metrics/AbcSize

  # Time estimation for air travel. For planes take-off and landing took nearly same amount.
  # Longer the distance shorter the time. Flying out at high altitude makes less air resistance / more speed
  def distance_time_estimation(air_distance)
    case air_distance
    when 0..400
      (air_distance / 10) + 30
    when 400..1000
      (air_distance / 11.25) + 30
    else
      (air_distance / 12.5) + 25
    end
  end

  def description_text(travel_method, city_array, result_set)
    travel_method + ' travel distance between ' + city_array[0]['name'] + ' and ' + city_array[1]['name'] + ' is ' +
      result_set[0].to_s + ' km. Estimated air travel would take ' + result_set[1].to_s + ' minutes.'
  end
end
