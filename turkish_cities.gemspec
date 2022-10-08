lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turkish_cities/version'

Gem::Specification.new do |s|
  s.name                  = 'turkish_cities'
  s.version               = TurkishCities::VERSION
  s.required_ruby_version = '>= 2.5.1'
  s.authors               = ['Semih Arslanoglu']
  s.email                 = 'arslanoglusemih93@gmail.com'

  s.summary               = 'List and find Turkish cities'
  s.description           = 'List and find Turkish cities via name, district name, post code, plate number. Calculate air travel distance between cities and get realistic estimates of travel time'
  s.homepage              = 'https://github.com/sarslanoglu/turkish_cities'
  s.license               = 'MIT'

  s.files                 = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.test_files            = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths         = ['lib']

  s.add_dependency 'i18n', ['>= 0.6.4', '<= 2']

  s.add_development_dependency 'bundler', '~> 2.3.23'
  s.add_development_dependency 'codecov', '~> 0.6.0'
  s.add_development_dependency 'rake', '~> 13.0.6'
  s.add_development_dependency 'rspec', '~> 3.11.0'
  s.add_development_dependency 'rubocop', '~> 1.36.0'

  if s.respond_to?(:metadata)
    s.metadata['changelog_uri'] = 'https://github.com/sarslanoglu/turkish_cities/blob/master/CHANGELOG.md'
    s.metadata['source_code_uri'] = 'https://github.com/sarslanoglu/turkish_cities'
    s.metadata['bug_tracker_uri'] = 'https://github.com/sarslanoglu/turkish_cities/issues'
  end
end
