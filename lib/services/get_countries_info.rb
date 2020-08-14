# frozen_string_literal: true

module Services
  class GetCountriesInfo
    attr_reader :response

    BASE_URL = Rails.application.credentials[:covid][:base_url]
    public_constant :BASE_URL

    def fetch_countries
      path = Rails.application.credentials[:covid][:countries][:path]
      url = BASE_URL + path
      uri = URI(url)
      @response = Net::HTTP.get_response(uri)
      return JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    rescue StandardError
      [{ error: { message: I18n.t('covid.api_error') } }]
    end
  end
end
