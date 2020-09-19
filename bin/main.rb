recipe_spec = {
    base_url: 'https://natashaskitchen.com/category/',
    type: 'breakfast',
    prep_time_min: 5
}
recipes = get_data(recipe_spec)
puts "Count: #{recipes.count}"
recipes.each do |item|
    puts "Recipe Name = #{item[:name]} prep_time=#{item[:prep_time_min]}"
end