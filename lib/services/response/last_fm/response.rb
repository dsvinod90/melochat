# frozen_string_literal: true

module Services
  module Response
    module LastFm
      class Response
        attr_reader :response, :body

        def initialize(response)
          @response = response
          @body = ActiveSupport::JSON.decode(response.body)
        end

        def success?
          response.is_a?(Net::HTTPSuccess)
        end

        def failure?
          body['error'].present?
        end

        def error
          body['message']
        end
      end
    end
  end
end
