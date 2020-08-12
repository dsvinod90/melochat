module Services
    module Response
        class RandomTriviaResponse
            attr_reader :response, :body

            def initialize(response)
                @response = response
                @body = response.body
            end

            def success?
                response.is_a?(Net::HTTPSuccess)
            end
        end
    end
end