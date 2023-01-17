class User < ApplicationRecord 
  validates_presence_of :password, :name, :api_key 
  validates :email, uniqueness: true, presence: true  
  has_secure_password
end