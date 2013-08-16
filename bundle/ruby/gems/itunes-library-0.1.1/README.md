iTunes Library
==============

A Ruby library that makes it easy to dig around your iTunes Library metadata.

Installation
------------

    gem install itunes-library

Usage
-----

    require 'itunes/library'
    library = ITunes::Library.load("~/Music/iTunes/iTunes Library.xml")

    library.playlists.map(&:name) #=> ["90's Music", "Classical Music", "Recently Played", ...]

    library.music.tracks.select { |t| t.artist == "Foo Fighters" }.inject(0) { |n, t| n + t.play_count } #=> 4261

    library.podcasts.tracks.select { |t| t.unplayed? }

License
-------

Copyright (c) 2011 Joshua Peek.

Released under the MIT license. See `LICENSE` for details.
