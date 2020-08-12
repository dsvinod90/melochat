class SpaceController < ApplicationController
    CACHE_EXPIRY    = 2.hours

    def apod
        space_info = Rails.cache.fetch('space_info', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetSpaceInfo.new.get_apod_data
        end
        render json: space_info.body
    end

    def asteroid_news
    end
end