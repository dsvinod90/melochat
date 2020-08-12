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
        end
    end
end