source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :unit_tests do
  gem 'rake', :require => false
  gem 'rspec-puppet', :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'puppet-lint', :require => false
  gem 'simplecov', :require => false
  gem 'puppet_facts', :require => false
  gem 'json', :require => false
  if RUBY_VERSION < '2.0.0'
    gem 'metadata-json-lint', '~> 1.1.0',  :require => false
  else
    gem 'metadata-json-lint', '~> 2.2.0',  :require => false
  end
end

group :system_tests do
  gem 'beaker-rspec', :require => false
  gem 'serverspec', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby
