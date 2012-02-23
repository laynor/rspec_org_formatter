Gem::Specification.new do |s|
  s.name = 'rspec_org_formatter'
  s.version = '0.2.0'
  s.date = '2012-01-07'
  s.summary = "RSpec Org Formatter"
  s.description = "RSpec results meant to be viewed in an emacs org buffer"
  s.authors = ['Alessandro Piras']
  s.email = 'laynor@gmail.com'
  s.files = ['lib/rspec_org_formatter.rb', 'lib/rspec/core/formatters/org_formatter.rb', 'README.md', 'Gemfile']
  s.add_dependency "rspec", ">= 2.6.0"
  s.require_path = 'lib'
  s.homepage = 'https://github.com/laynor/rspec_org_formatter'
end
    
    
