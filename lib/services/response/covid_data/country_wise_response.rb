module Services
    module Response
        module CovidData
            class CountryWiseResponse
                attr_reader :response, :body

                def initialize(response)
                    @response = response
                    @body = ActiveSupport::JSON.decode(response.body)
                end

                def success?
                    response.is_a?(Net::HTTPSuccess)
                end

                def latest_data
                    body.last
                end

                def confirmed
                    latest_data['Confirmed']
                end
                
                def deaths
                    latest_data['Deaths']
                end

                def recovered
                    latest_data['Recovered']
                end

                def active
                    latest_data['Active']
                end

                def date_of_report
                    latest_data['Date']
                end

                def country
                    latest_data['Country']
                end
            end
        end
    end
end