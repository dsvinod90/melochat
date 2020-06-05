require 'services/get_countries_info'

desc "Print reminder about eating more fruit."
task :get_countries => :environment do
    countries = ::Services::GetCountriesInfo.new.get_countries
    countries.each do |country|
        Country.create(name: country['Country'], slug: country['Slug'], code: country['ISO2'])
    end
end