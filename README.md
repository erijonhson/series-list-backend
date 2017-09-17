# Series List

Steps are necessary to get the application up and running.

* Ruby 2.4.0 and Rails 5.0.6 version
* System dependencies
  + postgresql with pg 0.18
  + server with puma 3.0
  + CORS with rack-cors
  + Integration for windows infos with tzinfo-data
  + Authentication with devise and devise_token_auth
  + JSON serialization with active_model_serializers
* Configuration
  + To install all dependencies, run:
    ```
    bundle install
    ```
  + Configure /config/database.yml with correct username and password
  + For create the database, run:
    ```
    rake db:drop db:create db:migrate db:schema:load db:test:prepare db:test:load
    ``` 
* For the test suite, run:
  ```
  bundle exec spring rspec --format=d
  ```
* Services 
    **Series API**
        GET /api/v1/series
            when no filter param is sent
            returns status code 200
            returns 5 series from database
        GET /api/v1/series/:id
            returns status code 200
            returns the json for serie
        POST /api/v1/series
            when the params are invalid
                returns status code 422
                returns the json error for imdb
                doesn't saves the serie in the database
            when the params are valid
                assigns the created serie to the current user
                returns the json for created serie
                returns status code 201
                saves the serie in the database
        PUT /api/v1/series/:id
            when the params are valid
                updates the serie in the database
                returns the json for updated serie
                returns status code 200
            when the params are invalid
                returns the json error for imdb
                returns status code 422
                doesn't updates the imdb in the database
        DELETE /api/v1/series/:id
            removes the task from the database
            returns status code 204
    **Users API**
        PUT /api/v1/auth
            when the request params are valid
                returns status 200
                returns json data for the updated user
            when the request params are invalid
                return status 422
                return json data for the errors
        DELETE /api/v1/auth
            returns status 200
            removes the user from database
        GET /api/v1/auth/validate_token
            when the request headers are valid
                returns the user id
                returns status 200
            when the request headers are invalid
                returns status 401
        POST /api/v1/auth
            when the request params are invalid
                returns json data for the errors
                returns status 422
            when the request params are valid
                returns json data for the created user
                returns status 200
    **Sessions API**
        POST /api/v1/auth/sign_in
            when the credentials are correct
                returns the authentication data in the headers
                return status code 200
            when the credentials are incorrect
                return status code 401
                returns the json data for the errors
        DELETE /api/v1/auth/sign_out
            changes the user auth token
            returns status code 200
    **User**
        should validate that :email is case-insensitively unique
        should validate that :name cannot be empty/falsy
        should validate that :password_confirmation matches :password
        should have many serie dependent => destroy
        should validate that :email cannot be empty/falsy
        should allow :email to be ‹"example@email.com"›
    **Serie**
        should respond to #user_id
        should respond to #imdb
        should respond to #serie_type
        should belong to user
        should respond to #last_episode
        should validate that :imdb cannot be empty/falsy
        should respond to #my_rating
