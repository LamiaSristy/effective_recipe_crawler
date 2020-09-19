require 'nokogiri'
require './lib/parser.rb'

RSpec.describe 'parser class methods' do
    let(:mock_url) { 'https://example.com/test-path/'}
    let(:mock_response) { instance_double(HTTParty::Response, body: mock_response_body) }
    let(:mock_response_body) { 'response_body' }

    context 'test parse_page' do       
        it 'should return a parsed HTML page with nokogiri injected.' do
            allow(HTTParty).to receive(:get).and_return(mock_response)
            parsed_element = Parser.parse_page(mock_url)
            expect(parsed_element.to_html).to eql(mock_response_body)
        end
    end

    context 'test  parse_url' do
        it 'should return a parsed HTML page with nokogiri injected in all lines.' do
            element = Nokogiri::HTML.fragment('<a href="https://example.com/test-path/">testing</a>')
            expect(Parser.parse_url(element)).to eql(mock_url)
        end
    end

end