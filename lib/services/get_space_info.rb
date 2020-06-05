module Services
    class GetSpaceInfo
        attr_reader :response

        BASE_URL = Rails.application.credentials[:nasa][:base_url]
        API_KEY = Rails.application.credentials[:nasa][:secret_key]

        def get_apod_data
            path = Rails.application.credentials[:nasa][:apod][:path]
            url = BASE_URL + path
            params = { date: Date.current.strftime('%Y-%m-%d'), api_key: API_KEY }
            uri = URI(url)
            uri.query = URI.encode_www_form(params)
            @response = Net::HTTP.get_response(uri)
            return JSON.parse(response.body)if response.is_a?(Net::HTTPSuccess)
        rescue
            return { error: { message: I18n.t('nasa.api_error')}}
        end
    end
end