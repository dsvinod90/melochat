module Services
    class GetSpaceInfo
        NASA_BASE_URL = Rails.application.credentials[:nasa][:base_url]
        NOTIFY_BASE_URL = Rails.application.credentials[:notify][:base_url]
        API_KEY = Rails.application.credentials[:nasa][:secret_key]

        def get_apod_data
            url = NASA_BASE_URL + apod_path
            params = { date: Date.current.strftime('%Y-%m-%d'), api_key: API_KEY }
            raw_response = Services::Request.get(url, params)
            raw_response.present? ? Services::Response::SpaceResponse.new(raw_response) : nil
        end

        def get_asteroid_news
            url = NASA_BASE_URL + asteroid_news_path
            params = {
                start_date: Date.current.strftime('%Y-%m-%d'),
                end_date: Date.current.strftime('%Y-%m-%d'),
                api_key: API_KEY
            }
            raw_response = Services::Request.get(url, params)
            raw_response.present? ? Services::Response::SpaceResponse.new(raw_response) : nil
        end

        def get_astronauts_in_space
            url = NOTIFY_BASE_URL + astronauts_in_space_path
            params = {}
            options = { use_ssl: false }
            raw_response = Services::Request.get(url, params, options)
            raw_response.present? ? Services::Response::SpaceResponse.new(raw_response) : nil
        end

        private

        def apod_path
            Rails.application.credentials[:nasa][:apod][:path]
        end

        def asteroid_news_path
            Rails.application.credentials[:nasa][:asteroid_news][:path]
        end

        def astronauts_in_space_path
            Rails.application.credentials[:notify][:astronauts][:path]
        end

    end
end