# frozen_string_literal: true

module Services
  class GetCovidUpdates
    attr_reader :response

    BASE_URL = Rails.application.credentials[:covid][:base_url]
    public_constant :BASE_URL

    def fetch_stats(country)
      url = BASE_URL + path_for_country_wise_stats(country)
      raw_response = Services::Request.get(url)
      raw_response.present? ? Services::Response::CovidData::CountryWiseResponse.new(raw_response) : nil
    end

    def fetch_global_status
      url = BASE_URL + path_for_global_status
      raw_response = Services::Request.get(url)
      raw_response.present? ? Services::Response::CovidData::GlobalResponse.new(raw_response) : nil
    end

    private

    def path_for_country_wise_stats(country)
      Rails.application.credentials[:covid][:live_updates][:path] + country
    end

    def path_for_global_status
      Rails.application.credentials[:covid][:summary][:path]
    end
  end
end
