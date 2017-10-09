require 'uri'
require 'net/http'
require 'nokogiri'
require 'open-uri'

class Page
  attr_reader :uri, :html, :body
  def initialize(url)
    @uri = URI.parse(url)
  end
  
  def fetch!
    puts 'Fetching...'
    @html = Net::HTTP.get_response(@uri)
    # Need to redirect, alternatively can just use open-uri: html = open('http://***/xyz')
    if html.code == "301"
      @html = Net::HTTP.get_response(URI.parse(html.header['location']))
    end
    @body = Nokogiri::HTML(html.body)
  end
  
  def title
    puts 'Title: ' + @body.css('title').text
  end
  
  def links
    # Research alert!
    # How do you use Nokogiri to extract all the link URLs on a page?
    #
    # These should only be URLs that look like
    #   <a href="http://somesite.com/page.html">Click here!</a>
    # This would pull out "http://somesite.com/page.html"
    puts 'Links: '
    links = @body.css('a')
    puts links.map {|link| link["href"]}.compact
  end

end

# page = Page.new('http://www.nextacademy.com')
# page.fetch!
# page.title
# page.links
# p page.content_length
