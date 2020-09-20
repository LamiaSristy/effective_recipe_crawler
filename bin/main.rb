#!/usr/bin/env ruby

require_relative '../lib/parser.rb'
require_relative '../lib/recipe_crawler.rb'

crawler = RecipeCrawler.new('breakfast', 5)
puts 'crawling started...'
recipes = crawler.res_crawl
puts "Number of recipes for breatfasts that can be make within in 5 minutes : #{recipes.count}"
recipes.each do |item|
  puts "Recipe Name = #{item[:name]}, Time=#{item[:prep_time_min]}, URL=#{item[:url]}"
end
