module Services
    class Request
        attr_reader :url, :params, :options

        TIMEOUT_WINDOW = 5
        NAMESPACE = :service_request

        def self.get(url, params = {}, options = { use_ssl: true })
            new(url, params, options).get
        end

        def initialize(url, params, options)
            @url = url
            @params = params
            @options = options
        end

        def circuit
            Circuitbox.circuit(NAMESPACE, time_window: TIMEOUT_WINDOW, exceptions: [Net::OpenTimeout])
        end

        def headers
            {}
        end

        def ssl_required
            options[:use_ssl]
        end

        def get
            uri = URI(url)
            uri.query = URI.encode_www_form(params) if params.present?
            request = Net::HTTP::Get.new uri
            response = Net::HTTP.start(uri.host, uri.port, use_ssl: ssl_required) do |http|
                circuit.run do
                    http.request request
                end
            end
            response
        end
    end
end