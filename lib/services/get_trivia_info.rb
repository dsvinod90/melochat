module Services
    class GetTriviaInfo
        BASE_URL = Rails.application.credentials[:random_trivia][:base_url]

        def get_random_number_trivia
            url = BASE_URL + random_number_path
            params = {}
            options = { use_ssl: false }
            raw_response = Services::Request.get(url, params, options)
            raw_response.present? ? Services::Response::RandomTriviaResponse.new(raw_response) : nil
        end

        def get_random_date_trivia
            url = BASE_URL + random_date_path
            params = {}
            options = { use_ssl: false }
            raw_response = Services::Request.get(url, params, options)
            raw_response.present? ? Services::Response::RandomTriviaResponse.new(raw_response) : nil
        end

        private

        def random_number_path
            Rails.application.credentials[:random_trivia][:trivia][:path]
        end

        def random_date_path
            Rails.application.credentials[:random_trivia][:year][:path]
        end
    end
end