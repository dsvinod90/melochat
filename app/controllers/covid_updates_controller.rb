class CovidUpdatesController < ApplicationController
    CACHE_EXPIRY = 2.hours
    DEFAULT_COUNTRY = 'india'

    def index; end

    def country_summary
        country = params[:country] || DEFAULT_COUNTRY
        latest_status = Rails.cache.fetch("all_status_#{country}", expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        latest_status.latest_data['Date'] = Date.strptime(latest_status.latest_data['Date'])
        if  latest_status.present?
            render json: latest_status.latest_data
        else
            render json: { error: 'Data not available' }, status: 404
        end
    end

    def date_wise_country_summary
        country = params[:country] || DEFAULT_COUNTRY
        all_status = Rails.cache.fetch("all_status_#{country}", expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        weekly_data = all_status.body.select.with_index { |_, index| index % 7 == 0 }
        confirmed = weekly_data
            .group_by { |hash| converted_date(hash['Date']) }
            .map { |k, v| [k, v.first['Confirmed']] }
        deaths = weekly_data
            .group_by{|hash| converted_date(hash['Date']) }
            .map{|k, v| [k, v.first['Deaths']] }
        recovered = weekly_data
            .group_by{|hash| converted_date(hash['Date']) }
            .map{|k, v| [k, v.first['Recovered']] }
        output = [{name: 'Confirmed', data: confirmed}, {name: 'Deaths', data: deaths}, {name: 'Recovered', data: recovered}]
        render json: output
    end

    def global_summary
        summary = Rails.cache.fetch('global_summary', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetCovidUpdates.new.get_global_status
        end
        if summary.present?
            render json: summary.body['Global']
        else
            render json: { error: 'Data not available' }, status: 404
        end
    end

    private

    def converted_date(date)
        Date.parse(date).strftime('%Y-%m-%d')
    end
end
