class RecipesFacade 
  def self.recipes(country)
    recipes = RecipesService.recipes_for_country(country)[:hits]
    if recipes != []
      recipes.map do |recipe|
        Recipe.new(recipe[:recipe], country)
      end
    else
      []
    end
    
    

  end
end