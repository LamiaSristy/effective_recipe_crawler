require 'vcr_helper'
require 'vcr_helper'
require './lib/recipe_crawler.rb'


RSpec.describe 'scraper class methods' do

    context "#get_data" do
        it "crawls website and get_data" do
          VCR.use_cassette :mock_page do
            crawler = RecipeCrawler.new('breakfast', 5)
            recipes = crawler.get_data()
            expect(recipes.count).to be >= 3
          end
        end
      end
   
      context "#scraper" do
        it "crawls website and scraper data" do
          VCR.use_cassette :mock_page do
            crawler = RecipeCrawler.new('breakfast', 5)
            recipes = crawler.scraper()
            expect(recipes.count).to be >= 69
          end
        end
      end

      context "#list_scraper" do
        it "crawls website and scraper data" do
          VCR.use_cassette :mock_page do
            crawler = RecipeCrawler.new('breakfast', 5)

            url = "#{crawler.base_url}#{crawler.type}"
            parsed_page = Parser.parse_page(url)
            grid = parsed_page.css("div.postgrid")
            list = grid.css("div.li-a")

            recipes = crawler.list_scraper(list)
            expect(recipes.count).to eql 42
          end
        end
      end
end