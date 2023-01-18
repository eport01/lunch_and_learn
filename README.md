<div align="center">
  <h1>Lunch and Learn</h1>
</div>

## Project Overview 
- [Project Specs](https://backend.turing.edu/module3/projects/lunch_and_learn/)

Lunch and Learn is a RESTful API that a front-end team can expose in order for a user to search for cuisines by country, learn more about each country, and save favorite recipes to access later.  
The back-end handles the project's API consumption and acts as the interface to the project's database.

### Learning Goals 
- Expose an API for CRUD functionality 
- Expose an API that aggregates data from multiple external APIs
- Service Oriented Architecture 
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## Setup 
1. Clone the repository
2. cd into the root directory
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
5. You may run the RSpec test suite locally with `bundle exec rspec`
6. Run `rails s` to access the endpoints locally

## Available Endpoints 
Back End Server: http://localhost:3000

<details close>

<summary>Get Recipes for a Particular Country</summary> 

Request: <br>
```
GET /api/v1/recipes?country=#{country}
```

JSON Response Example: 
```json
{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/."
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```
</details>

<details close>

<summary>Get Learning Resources for a Particular Country</summary> 

Request: <br>
```
GET /api/v1/learning_resources?country=#{country}
```

JSON Response Example: 
```json
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples landmark during daytime",
                    "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "five brown wooden boats",
                    "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "orange temples during daytime",
                    "url": "https://images.unsplash.com/photo-1563492065599-3520f775eeed?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwzfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {...},
                {...},
                {...},
                {etc},
              ]
        }
    }
}
``` 
</details>

<details close>

<summary>User Registration</summary>

Request: <br>
```
POST /api/v1/users
```
Send a JSON payload in the body of the request:
```json 
{
  "name": "Emily",
  "email": "emilylovesdogs@dogsrule.com", 
  "password": "1234"
}
```

JSON Response Example: 

```json
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "Emily",
      "email": "emilylovesdogs@dogsrule.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

</details>

<details close>

<summary>Add Favorites</summary>  

Request: <br>
```
POST /api/v1/favorites
```
Send a JSON payload in the body of the request:
```json 
{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```
JSON Response Example: 
```json
{
    "success": "Favorite added successfully"
}
```
</details>

<details close>

<summary>Get a User's Favorites</summary> 

Request: <br>
```
GET /api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4
```

JSON Response Example: 
```json
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
    ]
 }
 ```
</details>

<details close>

<summary>Delete a Favorite From a User</summary> 

Request: <br>
```
DELETE /api/v1/favorites
```
Send a JSON payload in the body of the request:
```json 
{
  "favorite_id": 4, 
  "api_key": "697a91baaff5a683a6c8e8e13d1b928c"
}
```
JSON Response Example: 
```json
{message: "The recipe was successfully deleted from your favorites"}
```
</details>
