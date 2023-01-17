class FavoriteSerializer 
  include JSONAPI::Serializer
  attributes :recipe_title, :recipe_link, :country 
end