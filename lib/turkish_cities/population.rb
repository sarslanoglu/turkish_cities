# frozen_string_literal: true

require 'i18n'
require 'yaml'

require_relative '../turkish_cities/helpers/decomposer_helper'

class Population
  include DecomposerHelper

  file_path = File.join(File.dirname(__FILE__), 'data/cities.yaml')
  CITY_LIST = YAML.load_file(file_path)

  MIN_POPULATION = 83_644
  MAX_POPULATION = 15_840_901

  def find_by_population(type, population_one, population_two = nil)
    result = find_population(type, population_one, population_two)

    result.length.positive? ? result : city_population_not_found_error
  end

  private

  def find_population(type, population_one, population_two)
    city_list = CITY_LIST

    case type
    when 'exact'
      check_input_range(population_one, self.class::MIN_POPULATION, self.class::MAX_POPULATION)
      exact_population(city_list, population_one)
    when 'below'
      check_input_range(population_one, self.class::MIN_POPULATION, Float::INFINITY)
      below_population(city_list, population_one)
    when 'above'
      check_input_range(population_one, 0, self.class::MAX_POPULATION)
      above_population(city_list, population_one)
    when 'between'
      between_population(city_list, population_one.to_i, population_two.to_i)
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
    find_by_between('population', city_list, population_one, population_two)
  end
end
