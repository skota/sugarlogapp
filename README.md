# Sugarlogapp


## What is this?
Sugarlogapp is a simple app to record and track blood sugar levels. The app has web and mobile components

  * Rest API to power a mobile backend
  * Mobile app will be built using the awesome flutter sdk.
  
## How do i use this repo?
To start your Phoenix server: Clone or fork this repo. Then 

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## running tests
Note: to run integration tests, start chromedriver in a new terminal
$/usr/local/bin/chromedriver

Then run mix
$ mix test --trace

trace is optional, but it gives a nice listing of the features..