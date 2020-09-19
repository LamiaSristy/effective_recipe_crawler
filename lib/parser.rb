require 'byebug'
require 'httparty'
require 'nokogiri'

class Parser 
    def parse_page(url)
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML.parse(unparsed_page.body)
        parsed_page
    end
end


