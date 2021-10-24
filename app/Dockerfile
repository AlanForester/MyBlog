FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

# Set exposed ports
EXPOSE 5000

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Create db
RUN mix ecto.create

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && \
    npm install

ADD . .

# USER default

CMD ["mix", "phx.server"]