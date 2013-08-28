import datetime
import json
import os
from plist_parser import XmlPropertyListParser, PropertyListParseError

HOME = os.environ['HOME']

EPOCH = datetime.datetime(1904, 1, 1, 0, 0)
def to_timestamp(utc_datetime):
    delta = utc_datetime - EPOCH
    return delta.total_seconds()

config_file = open(os.path.join(HOME, '.scrob', 'config.json'))
CONFIG = json.load(config_file)
config_file.close()


# TODO throw error is config is missing email

if 'itunes_xml_path' in CONFIG:
  ITUNES_XML_PATH = CONFIG['itunes_xml_path']
else:
  ITUNES_XML_PATH = os.path.join(HOME, 'Music', 'iTunes', 'iTunes Music Library.xml')

def get_recently_played_tracks(stream):
    since = to_timestamp(datetime.datetime.utcnow() - datetime.timedelta(days=1))
    parser = XmlPropertyListParser()
    tracks = []
    try:
        plist = parser.parse(stream)
        for trackid in plist['Tracks']:
            if 'Play Date' in plist['Tracks'][trackid]:
                stamp = plist['Tracks'][trackid]['Play Date']
                if stamp > since:
                    track_data = plist['Tracks'][trackid]
                    track = {
                        "title": track_data['Name'],
                        "artist": track_data['Artist'],
                        "album": track_data['Album'],
                        "play_date": track_data['Play Date UTC'],
                        "date_added": track_data['Date Added'],
                        "play_count": track_data['Play Count']
                    }
                    if 'Rating' in track_data:
                        track['rating'] = track_data['Rating']
                    tracks.append(track)
    finally:
        stream.close()
        return tracks

stream = open(ITUNES_XML_PATH)
out = {
    "email": CONFIG['email'],
    "time": datetime.datetime.utcnow(),
    "songs": get_recently_played_tracks(stream)
}

stamp = datetime.datetime.now().strftime("%Y-%m-%d")
cached_file = open(os.path.join(HOME, '.scrob', 'cached', stamp+'.json'), 'w')
dthandler = lambda obj: obj.isoformat() if isinstance(obj, datetime.datetime) else None
cached_file.write(json.dumps(out, default=dthandler))
cached_file.close()

# TODO loop over all files at ~/.scrob/cached and post them out

# print get_recently_played_tracks(stream)
