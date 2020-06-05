module Services
    class GetCovidUpdates
        attr_reader :response

        BASE_URL = Rails.application.credentials[:covid][:base_url]

        def get_stats(country)
            path = Rails.application.credentials[:covid][:live_updates][:path] + country
            url = BASE_URL + path
            uri = URI(url)
            @response = Net::HTTP.get_response(uri)
            return JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
        rescue
            return [{ error: { message: I18n.t('covid.api_error')}}]
        end

        def get_global_status
            path = Rails.application.credentials[:covid][:summary][:path]
            url = BASE_URL + path
            uri = URI(url)
            @response = Net::HTTP.get_response(uri)
            return JSON.parse(response.body)if response.is_a?(Net::HTTPSuccess)
        rescue
            return [{ error: { message: I18n.t('covid.api_error')}}]
        end
    end
end