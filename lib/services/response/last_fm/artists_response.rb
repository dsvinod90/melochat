# frozen_string_literal: true

module Services
  module Response
    module LastFm
      class ArtistsResponse < Response
        def all_artists
          body['results']['artistmatches']['artist']
        end

        def top_ten_artists
          all_artists.first(10)
        end

        def artists_count
          artists.count
        end

        def artist_details
          body['artist']
        end

        def artist_stats
          artist_details['stats']
        end

        def artist_tags
          artist_details['tags']['tag']
        end

        def similar_artists
          artist_details['similar']['artist']
        end

        def artist_bio
          artist_details['bio']
        end

        def country_top_artists
          body['topartists']['artist']
        end

        def country_artist_attributes
          body['topartists']['@attr']
        end

        def country_top_tracks
          body['tracks']['track']
        end

        def country_track_attributes
          body['tracks']['@attr']
        end

        def charts_top_artists
          body['artists']['artist']
        end

        def charts_top_tracks
          body['tracks']['track']
        end
      end
    end
  end
end
