# frozen_string_literal: true

class Elevation
  include DecomposerHelper

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)

  MIN_ELEVATION = 3
  MAX_ELEVATION = 1924

  def find_by_elevation(type, elevation_one, elevation_two = nil)
    city_list = CITY_LIST

    case type
    when 'below'
      check_input_range(elevation_one, self.class::MIN_ELEVATION, Float::INFINITY)
      below_elevation(city_list, elevation_one)
    when 'above'
      check_input_range(elevation_one, 0, self.class::MAX_ELEVATION)
      above_elevation(city_list, elevation_one)
    when 'between'
      between_elevation(city_list, elevation_one.to_i, elevation_two.to_i)
    else
      unsupported_elevation_type(type)
    end
  end

  private

  def below_elevation(city_list, elevation)
    city_list.map { |city| city['name'] if city['altitude'] < elevation }.compact
  end

  def above_elevation(city_list, elevation)
    city_list.map { |city| city['name'] if city['altitude'] > elevation }.compact
  end

  def between_elevation(city_list, elevation_one, elevation_two)
    find_by_between('altitude', city_list, elevation_one, elevation_two)
  end
end
