Gem::Specification.new do |s|
  s.name = 'rspec_org_formatter'
  s.version = '0.2.3'
  s.date = '2012-01-07'
  s.summary = "RSpec Org Formatter"
  s.description = "RSpec results meant to be viewed in an emacs org buffer"
  s.authors = ['Alessandro Piras']
  s.email = 'laynor@gmail.com'
  s.files         = `git ls-files`.split($/)
  s.add_dependency "rspec", ">= 2.6.0"
  s.require_path = 'lib'
  s.homepage = 'https://github.com/laynor/rspec_org_formatter'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'rspec', '~> 2.4'
  s.add_development_dependency 'rspec_org_formatter', '~> 0.2.2'
end

