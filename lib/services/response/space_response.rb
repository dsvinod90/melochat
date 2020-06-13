module Services
    module Response
        class SpaceResponse
            attr_reader :response, :body

            def initialize(response)
                @response = response
                @body = ActiveSupport::JSON.decode(response.body)
            end

            def success?
                response.is_a?(Net::HTTPSuccess)
            end

            def explanation
                body['explanation']
            end

            def title
                body['title']
            end

            def image_url
                body['url']
            end

            def date
                body['date']
            end
        end
    end
end