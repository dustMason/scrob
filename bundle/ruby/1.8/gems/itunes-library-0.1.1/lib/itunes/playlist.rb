module ITunes
  class Playlist
    def initialize(library, properties)
      @library    = library
      @properties = properties
    end

    def [](key)
      @properties[key]
    end

    def name
      self['Name']
    end

    def item_ids
      (self['Playlist Items'] || []).map { |t| t['Track ID'] }
    end

    def items
      @items ||= item_ids.map { |id| @library.fetch_track(id) }
    end
    alias_method :tracks, :items

    def size
      item_ids.size
    end

    def inspect
      "#<#{self.class.name} name=#{name.inspect} size=#{size}>"
    end
  end
end
