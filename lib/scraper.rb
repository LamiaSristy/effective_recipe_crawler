require 'byebug'
require 'httparty'
require 'nokogiri'
require_relative '../lib/parser.rb'

class Scraper
    
  def list_scraper(list)
    recipes = Array.new
    list.each do |recipecard|
      recipe_page_url = recipecard.css('a').attribute('href').value
      parsed_recipe_page = parse_page(recipe_page_url)
      recipe_container =  parsed_recipe_page.css('div.wprm-recipe-container')
      recipe = {
        name: recipe_container.css('h2.wprm-recipe-name').text,
        prep_time_min: recipe_container.css('span.wprm-recipe-prep_time-minutes').text.to_i,
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
      parsed_page = parse_page(paged_url)
      grid = parsed_page.css("div.postgrid")
      list = grid.css("div.li-a")
      recipes.push(*list_scraper(list))
      next_page = parsed_page.css('div.navright')
      if next_page.css('a').empty?
        has_next_page = false
      else
        paged_url = next_page.css('a').attribute('href').value
      end
    end    
    recipes
  end
    
  def get_data(crawler)
    recipes = scraper(crawler[:base_url], crawler[:type])
    recipes.select do |item|
      item[:prep_time_min] <= crawler[:prep_time_min]
    end
  end
end
