# frozen_string_literal: true

class ExploresController < ApplicationController
  add_breadcrumb 'Explore', :explores_path
  add_breadcrumb 'Artists', :artists_explores_path, only: %i[artists show_artists]

  def index; end

  def artists
    return unless artist_name.present?

    @response = Services::GetArtistsInfo.new(artist: artist_name).search_artists
  end

  def show_artists
    return unless artist_name.present?

    add_breadcrumb(artist_name, :show_artists_explores_path)
    @artist_info = Services::GetArtistsInfo.new(artist: artist_name).fetch_artist_info
  end

  def charts
    add_breadcrumb('Charts', :charts_explores_path)
    @chart_artist_info = Services::GetArtistsInfo.new.fetch_top_chart_artists
    @chart_track_info = Services::GetArtistsInfo.new.fetch_top_chart_tracks
  end

  def trending
    return unless country.present?

    add_breadcrumb('Trending', :trending_explores_path)
    if search_artists.present?
      @trending_artist_info = Services::GetArtistsInfo.new(country: country).fetch_top_chart_artists_by_country
    elsif search_tracks.present?
      @trending_track_info = Services::GetArtistsInfo.new(country: country).fetch_top_chart_tracks_by_country
    end
  end

  def artist_name
    params[:artist]
  end

  def country
    params[:country]
  end

  def search_artists
    params[:search_artists]
  end

  def search_tracks
    params[:search_tracks]
  end
end
