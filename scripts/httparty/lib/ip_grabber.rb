require 'httparty'

class IPGrabber
  def initialize()
    @url = "http://icanhazip.com"
  end

  def get
    response = HTTParty.get(@url)
    response.body.chomp
  end
end
