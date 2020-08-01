class CovidUpdatesController < ApplicationController
    def index
        country = params[:country] || 'india'
        @all_status = Rails.cache.fetch("all_status_#{country}", expires_in: 2.hours) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        @latest_status = @all_status.latest_data if @all_status.present?
    end
end
