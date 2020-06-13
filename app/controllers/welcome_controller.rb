class WelcomeController < ApplicationController
    CACHE_EXPIRY = 2.hours

    def home
        @space_info = Rails.cache.fetch('space_info', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetSpaceInfo.new.get_apod_data
        end
        country = params[:country]
        @latest_status = Rails.cache.fetch("all_status_#{country}", expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetCovidUpdates.new.get_stats(country)
        end
        @summary = Rails.cache.fetch('global_summary', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetCovidUpdates.new.get_global_status
        end
    end
end