module ITunes
  class Track
    def initialize(library, properties)
      @library    = library
      @properties = properties
    end

    def to_hash
      @properties
    end

    def [](key)
      @properties[key]
    end

    def id
      self['Track ID']
    end

    def persistent_id
      self['Persistent ID']
    end

    def name
      self['Name']
    end

    def artist
      self['Artist']
    end

    def album
      self['Album']
    end

    def number
      self['Track Number']
    end
    
    def genre
      self['Genre']
    end

    def year
      self['Year']
    end

    def composer
      self['Composer']
    end

    def season_number
      self['Season']
    end

    def episode_number
      self['Episode Order']
    end

    def date_added
      self['Date Added']
    end

    def last_played_at
      self['Play Date UTC']
    end
    
    def play_count
      self['Play Count'] || 0
    end

    def total_time
      self['Total Time'] / 1000
    end

    def kind
      self['Kind']
    end

    def audio?
      !video?
    end

    def video?
      self['Has Video'] || false
    end

    def movie?
      self['Movie'] || false
    end

    def tv_show?
      self['TV Show'] || false
    end

    def podcast?
      self['Podcast'] || false
    end

    def audiobook?
      kind =~ /Audible/ ? true : false
    end

    def unplayed?
      self['Unplayed'] == true || play_count == 0
    end

    def played?
      !unplayed?
    end

    def inspect
      "#<#{self.class.name} name=#{name.inspect}>"
    end
  end
end
