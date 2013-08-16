require 'plist'

require 'itunes/playlist'
require 'itunes/track'

module ITunes
  class Library
    def self.load(file)
      new(Plist::parse_xml(file))
    end

    def initialize(properties)
      @properties = properties || {}
    end

    def [](key)
      @properties[key]
    end

    def playlists
      @playlists ||= self['Playlists'].map { |p| Playlist.new(self, p) }
    end

    def find_playlist(name)
      playlists.detect { |p| p.name == name }
    end

    def music
      find_playlist 'Music'
    end

    def movies
      find_playlist 'Movies'
    end

    def tv_shows
      find_playlist 'TV Shows'
    end

    def podcasts
      find_playlist 'Podcasts'
    end

    def books
      find_playlist 'Books'
    end

    def track_ids
      self['Tracks']
    end

    def fetch_track(id)
      Track.new(self, track_ids[id.to_s])
    end

    def tracks
      @tracks ||= self['Tracks'].values.map { |t| Track.new(self, t) }
    end

    def size
      track_ids.size
    end

    def inspect
      "#<#{self.class.name} size=#{size}>"
    end
  end
end
