lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turkish_cities/version'

Gem::Specification.new do |s|
  s.name                  = 'turkish_cities'
  s.version               = TurkishCities::VERSION
  s.required_ruby_version = '>= 2.5.1'
  s.authors               = ['Semih Arslanoglu']
  s.email                 = 'arslanoglusemih93@gmail.com'

  s.date                  = '2020-04-13'
  s.summary               = 'List and find Turkish cities'
  s.description           = 'Simple ruby gem for listing and finding Turkish cities via name, plate number or size'
  s.homepage              = 'https://github.com/sarslanoglu/turkish_cities'
  s.license               = 'MIT'

  s.files                 = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.test_files            = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths         = ['lib']

  s.add_dependency 'i18n', ['>= 0.6.4', '<= 2']

  s.add_development_dependency 'bundler', '~> 2.1.4'
  s.add_development_dependency 'coveralls', '~> 0.8.23'
  s.add_development_dependency 'rspec', '~> 3.9.0'
  s.add_development_dependency 'rubocop', '~> 0.87.1'

  if s.respond_to?(:metadata)
    s.metadata['changelog_uri'] = 'https://github.com/sarslanoglu/turkish_cities/blob/master/CHANGELOG.md'
    s.metadata['source_code_uri'] = 'https://github.com/sarslanoglu/turkish_cities'
    s.metadata['bug_tracker_uri'] = 'https://github.com/sarslanoglu/turkish_cities/issues'
  end
end
