module WelcomeHelper
    def apod_data_success_response?(apod_data_response)
        apod_data_response.success?
    end

    def apod_data_explanation(apod_data_response)
        apod_data_response.explanation
    end

    def apod_data_title(apod_data_response)
        apod_data_response.title
    end

    def apod_data_date(apod_data_response)
        apod_data_response.date
    end

    def apod_data_image(apod_data_response)
        apod_data_response.image_url
    end

    def country_wise_covid_response_success?(covid_status_response)
        covid_status_response.success?
    end

    def country_wise_confirmed(covid_status_response)
        covid_status_response.confirmed
    end

    def country_wise_deaths(covid_status_response)
        covid_status_response.deaths
    end

    def country_wise_recovered(covid_status_response)
        covid_status_response.recovered
    end

    def country_wise_active(covid_status_response)
        covid_status_response.active
    end

    def country_wise_date_of_report(covid_status_response)
        covid_status_response.date_of_report
    end

    def global_covid_response_success?(global_status_response)
        global_status_response.success?
    end

    def global_new_confirmed(global_status_response)
        global_status_response.new_confirmed
    end

    def global_total_confirmed(global_status_response)
        global_status_response.total_confirmed
    end

    def global_new_deaths(global_status_response)
        global_status_response.new_deaths
    end

    def global_total_deaths(global_status_response)
        global_status_response.total_deaths
    end

    def global_new_recovered(global_status_response)
        global_status_response.new_recovered
    end

    def global_total_recovered(global_status_response)
        global_status_response.total_recovered
    end
end
