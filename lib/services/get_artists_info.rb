# frozen_string_literal: true

module Services
  class GetArtistsInfo
    BASE_URL = Rails.application.credentials[:last_fm][:base_url]
    public_constant :BASE_URL
    API_KEY = Rails.application.credentials[:last_fm][:api_key]
    public_constant :API_KEY

    attr_reader :artist, :country

    def initialize(options = {})
      @artist = options[:artist]
      @country = options[:country]
    end

    def search_artists
      raw_response = Services::Request.get(BASE_URL, search_artists_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    def fetch_artist_info
      raw_response = Services::Request.get(BASE_URL, artist_info_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    def fetch_top_chart_artists_by_country
      raw_response = Services::Request.get(BASE_URL, chart_artist_info_by_country_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    def fetch_top_chart_tracks_by_country
      raw_response = Services::Request.get(BASE_URL, chart_tracks_info_by_country_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    def fetch_top_chart_artists
      raw_response = Services::Request.get(BASE_URL, top_chart_artist_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    def fetch_top_chart_tracks
      raw_response = Services::Request.get(BASE_URL, top_chart_track_params, use_ssl: false)
      raw_response.present? ? Services::Response::LastFm::ArtistsResponse.new(raw_response) : nil
    end

    private

    def search_artists_params
      {
        method: 'artist.search',
        artist: artist,
        api_key: API_KEY,
        format: 'json'
      }
    end

    def artist_info_params
      {
        method: 'artist.getinfo',
        artist: artist,
        api_key: API_KEY,
        format: 'json'
      }
    end

    def chart_artist_info_by_country_params
      {
        method: 'geo.gettopartists',
        country: country,
        api_key: API_KEY,
        format: 'json'
      }
    end

    def chart_tracks_info_by_country_params
      {
        method: 'geo.gettoptracks',
        country: country,
        api_key: API_KEY,
        format: 'json'
      }
    end

    def top_chart_artist_params
      {
        method: 'chart.gettopartists',
        api_key: API_KEY,
        format: 'json'
      }
    end

    def top_chart_track_params
      {
        method: 'chart.gettoptracks',
        api_key: API_KEY,
        format: 'json'
      }
    end
  end
end
