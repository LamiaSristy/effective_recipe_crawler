require 'byebug'
require 'httparty'
require 'nokogiri'

class Parser 
    def self.parse_page(url)
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML.parse(unparsed_page.body)
        parsed_page
    end

    def self.parse_url(element)
        url = element.css('a').attribute('href').value
        url
    end
end


