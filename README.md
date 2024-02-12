# About this application

This application is a Rails API back end for a front end React app
The API lives at
[http://localhost:3000](http://localhost:3000)

This app uses ruby 3.1.2 rails 7.1.3 with a PostgreSQL database

To bootstrap the application you need to create a username/password pair of rails/rails OR
edit `config/database.yml` and change the username/password to an existing one in your system.

After that:
- `bundle`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`
- `bundle exec rake db:seed`
- `bin/dev`

Run the test suite with `bundle exec rspec`

Test the API with [http://localhost:3000/api/search?query=vod](http://localhost:3000/api/search?query=vod)

You should receive a JSON dump of cocktail data

### ## Enhancements I'd add, given time, in rough order of importance
- I'd version the API, but the requirements stated no version number in the API path, so I omitted this
- I'd replace the to_json serialization with JBuilder or ActiveModel Serialization
- I'd create a Docker compose file of both the Rails and React app to run them without manual steps
- I'd integrate the React front end application into this Rails application

