module Services
    class GetCountriesInfo
        attr_reader :response

        BASE_URL = Rails.application.credentials[:covid][:base_url]

        def get_countries
            path = Rails.application.credentials[:covid][:countries][:path]
            url = BASE_URL + path
            uri = URI(url)
            @response = Net::HTTP.get_response(uri)
            return JSON.parse(response.body)if response.is_a?(Net::HTTPSuccess)
        rescue
            return [{ error: { message: I18n.t('covid.api_error')}}]
        end
    end
end