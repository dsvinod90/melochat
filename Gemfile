# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby('2.6.3')

gem('actionpack', '>= 5.2.4.3')
gem('actionview', '>= 5.2.4.2')
gem('activejob', '>= 5.1.6.1')
gem('active_model_serializers', '~> 0.10.0')
gem('activesupport', '>= 5.2.4.3')
gem('aws-sdk-s3', '~> 1')
gem('bootsnap', '>= 1.4.2', require: false)
gem('bootstrap', '~> 4.3.1')
gem('bootstrap-sass')
gem('byebug', '~> 11.1')
gem('chartkick')
gem('circuitbox')
gem('coderay')
gem('devise')
gem('font-awesome-rails')
gem('jbuilder', '~> 2.7')
gem('jquery-rails')
gem('lastfm')
gem('md_simple_editor')
gem('puma', '~> 4.3')
gem('rails', '~> 6.0.1')
gem('react-rails')
gem('redcarpet')
gem('rubocop')
gem('rubyzip', '>= 1.3.0')
gem('sass-rails', '>= 6')
gem('sqlite3', '~> 1.4')
gem('turbolinks', '~> 5')
gem('webmock', '~> 3.7', '>= 3.7.6')
gem('webpacker')

group :development, :test do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg', '0.20.0'
end

gem('tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby])
