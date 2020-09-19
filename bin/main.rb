#!/usr/bin/env ruby

require_relative '../lib/parser.rb'
require_relative '../lib/scraper.rb'


crawler = RecipeCrawler.new('breakfast', 5)
recipes = crawler.get_data()
puts "Count: #{recipes.count}"
recipes.each do |item|
  puts "Recipe Name = #{item[:name]} prep_time=#{item[:prep_time_min]}"
end
