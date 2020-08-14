# frozen_string_literal: true

class SpaceController < ApplicationController
  CACHE_EXPIRY = 2.hours
  public_constant :CACHE_EXPIRY
  ASTEROID_IMAGE_PATH = 'https://9b16f79ca967fd0708d1-2713572fef44aa49ec323e813b06d2d9.ssl.cf2.rackcdn.com/1140x_a10-7_cTC/SCI-ASTEROID-STRIKE-1583289844.jpg'
  public_constant :ASTEROID_IMAGE_PATH
  ASTRONAUT_IMAGE_PATH = 'https://i.insider.com/5b85b2fd959f341c008b563e?width=1100&format=jpeg&auto=webp'
  public_constant :ASTRONAUT_IMAGE_PATH

  def apod
    space_info =
      Rails.cache.fetch('space_info', expires_in: CACHE_EXPIRY, skip_nil: true) do
        ::Services::GetSpaceInfo.new.fetch_apod_data
      end
    render(json: space_info.body)
  end

  def asteroid_news
    asteroid_data =
      Rails.cache.fetch('asteroid_news', expires_in: CACHE_EXPIRY, skip_nil: true) do
        ::Services::GetSpaceInfo.new.fetch_asteroid_news
      end
    response_body = asteroid_data.body
    date = Date.current.strftime('%Y-%m-%d')
    render(json: {
             element_count: response_body['element_count'],
             near_earth_objects: response_body['near_earth_objects'][date],
             asteroid_image: ASTEROID_IMAGE_PATH
           })
  end

  def astronauts_data
    astronauts_data =
      Rails.cache.fetch('astronauts_data', expires_in: CACHE_EXPIRY, skip_nil: true) do
        ::Services::GetSpaceInfo.new.fetch_astronauts_in_space
      end
    render(json: { astronaut_data: astronauts_data.body, astronaut_image: ASTRONAUT_IMAGE_PATH })
  end
end
