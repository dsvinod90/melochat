class WelcomeController < ApplicationController
    def home
        expires_in_seconds = Time.now.end_of_day + 1.day - Time.now
        @space_info = Rails.cache.fetch('space_info', expires_in: expires_in_seconds) do
            ::Services::GetSpaceInfo.new.get_apod_data
        end
        country = params[:country]
        all_status = Rails.cache.fetch("all_status_#{country}", expires_in: 2.hours) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        @latest_status = all_status.last
        @summary = Rails.cache.fetch('global_summary', expires_in: 2.hours) do
            ::Services::GetCovidUpdates.new.get_global_status
        end
    end
end