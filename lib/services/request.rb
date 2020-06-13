module Services
    class Request
        attr_reader :url, :params

        TIMEOUT_WINDOW = 5
        NAMESPACE = :service_request

        def self.get(url, params = {})
            new(url, params).get
        end

        def initialize(url, params)
            @url = url
            @params = params
        end

        def circuit
            Circuitbox.circuit(NAMESPACE, time_window: TIMEOUT_WINDOW, exceptions: [Net::OpenTimeout])
        end

        def headers
            {}
        end

        def get
            uri = URI(url)
            uri.query = URI.encode_www_form(params) if params.present?
            request = Net::HTTP::Get.new uri
            response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
                circuit.run do
                    http.request request
                end
            end
            response
        end
    end
end