class WelcomeController < ApplicationController
    def home
        expires_in_seconds = Time.now.end_of_day + 1.day - Time.now
        @space_info = Rails.cache.fetch('space_info', expires_in: expires_in_seconds) do
            ::Services::GetSpaceInfo.new.get_apod_data
        end
        all_status = ::Services::GetCovidUpdates.new.get_stats(params[:country])
        @latest_status = all_status.last
        @summary = ::Services::GetCovidUpdates.new.get_global_status
    end
end