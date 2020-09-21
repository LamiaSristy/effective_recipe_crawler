require 'vcr_helper'
require_relative '../lib/recipe_crawler.rb'

RSpec.describe 'scraper class methods' do
  context '#get_data' do
    it 'shows the numbers of the beakfast that can be made within 5 minutes are 3' do
      VCR.use_cassette :mock_page do
        crawler = RecipeCrawler.new('breakfast', 5)
        recipes = crawler.res_crawl
        expect(recipes.count).to be >= 3
      end
    end

    it 'returns 0 if negetive input given for time.' do
      VCR.use_cassette :mock_page do
        crawler = RecipeCrawler.new('breakfast', -5)
        recipes = crawler.res_crawl
        expect(recipes.count).to eql 0
      end
    end
  end

  context '#scraper' do
    it 'crawls website and shows total 69 breakfast recipes.' do
      VCR.use_cassette :mock_page do
        crawler = RecipeCrawler.new('breakfast', 5)
        recipes = crawler.send(:scraper)
        expect(recipes.count).to be >= 69
      end
    end
  end

  context '#list_scraper' do
    it 'crawls website and shows total 42 breakfast recipes are in the first page' do
      VCR.use_cassette :mock_page do
        crawler = RecipeCrawler.new('breakfast', 5)
        url = "#{crawler.base_url}#{crawler.type}"
        parsed_page = Parser.parse_page(url)
        grid = parsed_page.css('div.postgrid')
        list = grid.css('div.li-a')
        recipes = crawler.send(:list_scraper, list)
        expect(recipes.count).to eql 42
      end
    end

    it 'crawls website and  return 0 if any blank list given' do
      VCR.use_cassette :mock_page do
        crawler = RecipeCrawler.new('breakfast', 5)
        recipes = crawler.send(:list_scraper, [])
        expect(recipes.count).to eql 0
      end
    end
  end
end
