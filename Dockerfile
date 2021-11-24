FROM elixir:1.11.4

WORKDIR /app
COPY mix.exs /app/
COPY mix.lock /app/
COPY assets/package.json assets/package-lock.json assets/ 

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix deps.get \
  && mix deps.compile \
  && npm install --prefix assets

ADD . /app

RUN mix compile

CMD ["mix", "phx.server"]