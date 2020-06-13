module Services
    module Response
        module CovidData
            class GlobalResponse
                attr_reader :response, :body

                def initialize(response)
                    @response = response
                    @body = ActiveSupport::JSON.decode(response.body)
                end

                def global_stats
                    body['Global']
                end

                def country_wise_stats
                    body['Countries']
                end

                def success?
                    response.is_a?(Net::HTTPSuccess)
                end

                def new_confirmed
                    global_stats['NewConfirmed']
                end

                def total_confirmed
                    global_stats['TotalConfirmed']
                end

                def new_deaths
                    global_stats['NewDeaths']
                end

                def total_deaths
                    global_stats['TotalDeaths']
                end

                def new_recovered
                    global_stats['NewRecovered']
                end

                def total_recovered
                    global_stats['TotalRecovered']
                end
            end
        end
    end
end