require 'byebug'
require 'httparty'
require 'nokogiri'
require_relative './parser.rb'

class Crawler

end

class RecipeCrawler < Crawler
   
  attr_accessor :base_url, :type, :prep_time_min

  def initialize(type, prep_time_min)
    @base_url = 'https://natashaskitchen.com/category/'
    @type = type
    @prep_time_min = prep_time_min
  end
    
  def list_scraper(list)
    recipes = Array.new
    list.each do |recipecard|
      recipe_page_url = Parser.parse_url(recipecard)
      parsed_recipe_page = Parser.parse_page(recipe_page_url)
      recipe_container =  parsed_recipe_page.css('div.wprm-recipe-container')
      recipe = {
        name: recipe_container.css('h2.wprm-recipe-name').text,
        prep_time_min: recipe_container.css('span.wprm-recipe-total_time-hours').text.to_i*60 + recipe_container.css('span.wprm-recipe-total_time-minutes').text.to_i,
        cost_making: recipe_container.css('span.wprm-recipe-cuisine').text.strip,
        cuisine: recipe_container.css('span.wprm-recipe-newcuisine').text.strip,
        skill_level: recipe_container.css('span.wprm-recipe-course').text.strip,
        calories: recipe_container.css('span.wprm-recipe-calories').text.strip,
        url: recipe_page_url
        }
      recipes << recipe
    end
    recipes
  end

  def scraper(url, type) 
    paged_url = "#{url}#{type}"
    recipes = Array.new
    has_next_page = true
    while has_next_page
      puts paged_url
      parsed_page = Parser.parse_page(paged_url)
      grid = parsed_page.css("div.postgrid")
      list = grid.css("div.li-a")
      recipes.push(*list_scraper(list))

      next_page = parsed_page.css('div.navright')
      if next_page.css('a').empty?
        has_next_page = false
      else
        paged_url = Parser.parse_url(next_page)
      end
    end    
    recipes
  end
    
  def get_data()
    recipes = scraper(@base_url, @type)
    recipes.select do |item|
      item[:prep_time_min] <= @prep_time_min
    end
  end
end
