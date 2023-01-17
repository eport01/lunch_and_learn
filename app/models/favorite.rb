class Favorite < ApplicationRecord 
  belongs_to :user 
  # validate_presence_of :user_id, :country, :recipe_link, :recipe_title
end