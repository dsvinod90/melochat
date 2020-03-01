source 'https://rubygems.org'
 git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  ruby '2.6.3'

 gem 'rails', '~> 6.0.1'
 gem 'puma', '~> 4.1'
 gem 'sass-rails', '>= 6'
 gem 'webpacker', '~> 4.0'
 gem 'turbolinks', '~> 5'
 gem 'jbuilder', '~> 2.7'
 gem 'bootsnap', '>= 1.4.2', require: false
 gem 'bootstrap', '~> 4.3.1'
 gem 'jquery-rails'
 gem 'lastfm'
 gem 'aws-sdk-s3', '~> 1'

  group :development, :test do
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'sqlite3', '~> 1.4'
 end

  group :test do
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'
    gem 'webdrivers'
    gem 'sqlite3', '~> 1.4'
 end

  group :production do
    gem 'pg', '0.20.0'
  end

 gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
