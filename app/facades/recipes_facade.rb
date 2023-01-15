class RecipesFacade 
  def self.recipes(country)
    recipes = RecipesService.recipes_for_country(country)[:hits]
    if recipes != [] && recipes.count > 1
      recipes.map do |recipe|
        Recipe.new(recipe[:recipe], country)
      end
    elsif recipes != [] && recipes.count == 1
      Recipe.new(recipes[0][:recipe], country)
    else
      []
    end
    
    

  end
end