# frozen_string_literal: true

class Elevation
  include DecomposerHelper

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)

  def find_by_elevation(type, elevation_one, elevation_two)
    return [] unless check_number_range(elevation_one, 4, 1923)

    return [] if !elevation_two.nil? && !check_number_range(elevation_two, 4, 1923)

    result = find_elevation(type, elevation_one, elevation_two)

    result.length.positive? ? result : city_elevation_not_found_error
  end

  private

  def find_elevation(type, elevation_one, elevation_two)
    city_list = CITY_LIST

    case type
    when 'below'
      below_elevation(city_list, elevation_one)
    when 'above'
      above_elevation(city_list, elevation_one)
    when 'between'
      between_elevation(city_list, elevation_one, elevation_two)
    else
      unsupported_elevation_type(type)
    end
  end

  def below_elevation(city_list, elevation)
    city_list.map { |city| city['name'] if city['altitude'] < elevation }.compact
  end

  def above_elevation(city_list, elevation)
    city_list.map { |city| city['name'] if city['altitude'] > elevation }.compact
  end

  def between_elevation(city_list, elevation_one, elevation_two)
    if elevation_one > elevation_two
      bigger = elevation_one
      smaller = elevation_two
    else
      smaller = elevation_one
      bigger = elevation_two
    end

    city_list.map { |city| city['name'] if city['altitude'] > smaller && city['altitude'] < bigger }.compact
  end
end
