require 'nokogiri'
require 'open-uri'

class Scraper

  attr_accessor :rating, :image

  def initialize(url)
    @url = url
  end

  def scrape
    file = open(@url)
    doc = Nokogiri::HTML(file)
    @rating = doc.xpath("//span[@itemprop='rating']").text
    @image = doc.css(".picture").children.first["src"]
  end


end
