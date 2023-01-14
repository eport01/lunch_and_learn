class RecipesFacade 
  def self.recipes(country)
    RecipesService.recipes_for_country(country)[:hits].map do |recipe|
      Recipe.new(recipe[:recipe], country)
    end
  end
end