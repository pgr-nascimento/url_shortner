# UrlShortner

This application was made as part of STORD's hiring process.

In this application we can input an URL and shorten it to a smaller one, with this new URL the application can
redirects from the shorten URL to the original.

## What was used
- [Elixir](https://github.com/elixir-lang/elixir) the main language
- [Phoenix](https://github.com/phoenixframework/phoenix) is the framework that uses elixir to create WebApplication
- [Postgres](https://www.postgresql.org/) the default database of Phoenix
- [Credo](https://github.com/rrrene/credo) to analyze the code and suggests good practices.

## What next?

- I was in doubt if I put my thoughts here or keep them on notes.txt, so, I put some details and nexts steps that I would like to do
in notes.txt file. Please, go there and see my notes :D

## Setting up the project

**IMPORTANT** Make sure you have [Docker](https://docs.docker.com/engine/install/ubuntu/) and [Docker Compose](https://docs.docker.com/compose/install/) first.

``` 
# You may need to install dependencies first

$ docker-compose run --rm app mix deps.get

# Setup server database
$ docker-compose run --rm app mix ecto.setup

# Running client and server application
$ docker-compose up
```

## Running the tests

`$ docker-compose run -e MIX_ENV=test --rm app mix test`