# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class Population
  include DecomposerHelper

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)

  def find_by_population(type, population_one, population_two)
    return [] unless check_population_range(population_one, 83_645, 15_840_900)

    return [] if !population_two.nil? && !check_population_range(population_two, 83_645, 15_840_900)

    result = find_population(type, population_one, population_two)

    result.length.positive? ? result : city_population_not_found_error
  end

  private

  def find_population(type, population_one, population_two)
    city_list = CITY_LIST

    case type
    when 'exact'
      exact_population(city_list, population_one)
    when 'below'
      below_population(city_list, population_one)
    when 'above'
      above_population(city_list, population_one)
    when 'between'
      between_population(city_list, population_one, population_two)
    else
      unsupported_population_type(type)
    end
  end

  def exact_population(city_list, population)
    city_list.map { |city| city['name'] if city['population'] == population }.compact
  end

  def below_population(city_list, population)
    city_list.map { |city| city['name'] if city['population'] < population }.compact
  end

  def above_population(city_list, population)
    city_list.map { |city| city['name'] if city['population'] > population }.compact
  end

  def between_population(city_list, population_one, population_two)
    if population_one > population_two
      bigger = population_one
      smaller = population_two
    else
      smaller = population_one
      bigger = population_two
    end

    city_list.map { |city| city['name'] if city['population'] > smaller && city['population'] < bigger }.compact
  end
end
