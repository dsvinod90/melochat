class CovidUpdatesController < ApplicationController
    def index
        global_summary = Rails.cache.fetch('global_summary', expires_in: 2.hours) do
            ::Services::GetCovidUpdates.new.get_global_status
        end
        status = params[:status] || "TotalConfirmed"
        @country_wise_summary = global_summary['Countries']
            .map{ |hash| { hash['CountryCode'] => hash[status]} }
            .reduce(:merge) if global_summary.present?
        country = params[:country] || 'india'
        @all_status = Rails.cache.fetch("all_status_#{country}", expires_in: 2.hours) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        @latest_status = @all_status.last if @all_status.present?
    end
end
