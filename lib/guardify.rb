$:.unshift File.dirname(__FILE__)


require 'guardian'
require 'meta-spotify'
require 'ostruct'
require 'haml'
require 'tilt'

class Guardify


  def refresh
    get_data
    template = Tilt::HamlTemplate.new('views/index.haml')
    puts template.render(self)
    File.open("public/index.html", "w") do |f|
      f.write template.render(self)
    end
  end

  def get_data
    @albums = []
    results = Guardian.new.search_tag("tone/albumreview")
    results.each do |result|
      album = OpenStruct.new
      title = result["webTitle"]
      album.artist = artist_name(title)
      album.album_name = album_name(title)
      album.link = restult["webUrl"]
      spotify_response = MetaSpotify::Album.search("#{album.artist} #{album.name}")

      scraper = Scraper.new(album.link)
      scraper.scrape


      if spotify_response[:albums]
        album.spotify = spotify_response[:albums].first.uri rescue ""
      end
      @albums << album
    end
  end

  def artist_name(title)
    title.split(": ")[1].gsub("\342\200\223 review","")
  end

  def album_name(title)
    title.split(":").first
  end

end
