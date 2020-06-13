module Services
    class GetSpaceInfo
        BASE_URL = Rails.application.credentials[:nasa][:base_url]
        API_KEY = Rails.application.credentials[:nasa][:secret_key]

        def get_apod_data
            raw_response = Services::Request.get(url, params)
            raw_response.present? ? Services::Response::SpaceResponse.new(raw_response) : nil
        end

        private

        def path
            Rails.application.credentials[:nasa][:apod][:path]
        end

        def url
            BASE_URL + path
        end

        def params
            { date: Date.current.strftime('%Y-%m-%d'), api_key: API_KEY }
        end
    end
end