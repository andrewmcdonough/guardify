require 'httparty'

class Guardian
  include HTTParty

  def search_tag(tag)
    #self.get("http://content.guardianapis.com/search?tag=tone%2Falbumreview&format=json&pageSize=40")
    self.class.get("http://content.guardianapis.com/search?tag=#{tag}&format=json&pageSize=10")["response"]["results"]
  end

end
