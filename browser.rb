require 'net/http'
require 'nokogiri'
require 'uri'
load 'page.rb'

class Browser
  def run!
    # Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.
    
    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
    running = true
    while running
        puts 'Please enter an url or type quit to terminate the program: '
        url = gets.chomp
        if !(url =~ URI::regexp)
            if (url == 'quit')
                puts 'Goodbye~'
                running = false
            else
                puts 'You have entered an invalid url'
            end

        else
            page = Page.new(url)
            page.fetch!
            page.title
            page.links
        end
    end
  end
end

Browser.new.run!