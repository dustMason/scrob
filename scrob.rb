#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# set the running script to a low priority to avoid interrupting other stuff
Process.setpriority(Process::PRIO_PROCESS, 0, 20)

h = File.dirname($0)

# using Bundler standalone
require "#{h}/bundle/bundler/setup"
require "itunes/library"
require "json/pure"
require "net/http"
require "yaml"
require "pp"

# look! a monkey!
module ITunes
  class Track
    def rating
      self["Rating"] || 0
    end
  end
end

config = YAML.load_file(File.join(ENV['HOME'],".scrob/config.yml"))

itunes_xml_path = config["itunes_xml_path"] || File.join(ENV['HOME'],"/Music/iTunes/iTunes Music Library.xml")
library = ITunes::Library.load itunes_xml_path

errors = []
errors << "Couldn't find iTunes Music Library at #{itunes_xml_path}" if library["Playlists"].nil?
errors << "Your ~/.scrob/config.yml file is missing your email" unless config["email"]

unless errors.empty?
  puts errors
  exit
end

# grab all tracks that were listened to within the last week
yesterday = DateTime.now - 1
recents = library.music.tracks.select do |track|
  track.last_played_at && track.last_played_at > yesterday
end

out = {
  "email" => config["email"],
  "time" => Time.now
}
out["songs"] = recents.map do |song|
  {
    "title" => song.name,
    "artist" => song.artist,
    "album" => song.album,
    "play_date" => song.last_played_at,
    "rating" => song.rating,
    "play_count" => song.play_count,
    "date_added" => song.date_added
  }
end

# pp out

stamp = Time.now.strftime "%Y-%m-%d"
File.open(File.join(ENV["HOME"],".scrob/cached/#{stamp}.json"),"w") do |f|
  f.write(out.to_json)
end

# uri = URI('http://httpbin.org/post')
# uri = URI('http://dizouble.com/music')
# uri = URI('http://localhost:4567/songs')
uri = URI('http://whaleteeth.herokuapp.com/songs')
Dir.glob(File.join(ENV["HOME"],".scrob/cached/*.json")) do |json_file|
  File.open(json_file, "r") do |f|
    begin
      res = Net::HTTP.post_form(uri, 'data' => f.read)
      if res.kind_of?(Net::HTTPSuccess) || res.kind_of?(Net::HTTPSeeOther)
        File.delete json_file
      else
        puts "POST for #{json_file} failed, will try it again next time. Response below:"
        puts res.body
      end
    rescue SocketError => e
      puts "Couldn't reach #{uri}, will try it again next time"
    end
  end
end

