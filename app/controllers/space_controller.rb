class SpaceController < ApplicationController
    CACHE_EXPIRY    = 2.hours
    ASTEROID_IMAGE_PATH = 'https://9b16f79ca967fd0708d1-2713572fef44aa49ec323e813b06d2d9.ssl.cf2.rackcdn.com/1140x_a10-7_cTC/SCI-ASTEROID-STRIKE-1583289844.jpg'
    ASTRONAUT_IMAGE_PATH = 'https://i.insider.com/5b85b2fd959f341c008b563e?width=1100&format=jpeg&auto=webp'

    def apod
        space_info = Rails.cache.fetch('space_info', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetSpaceInfo.new.get_apod_data
        end
        render json: space_info.body
    end

    def asteroid_news
        asteroid_data = Rails.cache.fetch('asteroid_news', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetSpaceInfo.new.get_asteroid_news
        end.body
        date = Date.current.strftime('%Y-%m-%d')
        render json: { element_count: asteroid_data['element_count'], near_earth_objects: asteroid_data['near_earth_objects'][date], asteroid_image: ASTEROID_IMAGE_PATH }
    end

    def astronauts_data
        astronauts_data = Rails.cache.fetch('astronauts_data', expires_in: CACHE_EXPIRY, skip_nil: true) do
            ::Services::GetSpaceInfo.new.get_astronauts_in_space
        end
        render json: { astronaut_data: astronauts_data.body, astronaut_image:  ASTRONAUT_IMAGE_PATH }
    end
end