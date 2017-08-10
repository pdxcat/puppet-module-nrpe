source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :unit_tests do
  gem 'rake', :require => false
  gem 'rspec-puppet', :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'puppet-lint', :require => false
  gem 'simplecov', :require => false
  gem 'puppet_facts', :require => false
  gem 'json', :require => false
  # The following gems need specific versions for Ruby 1.9.3
  gem 'metadata-json-lint', '< 2.0'
  gem 'public_suffix', '~> 1.4.6'
  gem 'nokogiri', '< 1.7.0'
  gem 'mime-types', '<= 2.6.2'
  gem 'retriable', '~> 1.4'
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
