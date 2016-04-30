# Vuejs On Phoenix

A port of [vuejs_on_rails](https://github.com/gauravtiwari/vuejs_on_rails) in Phoenix to explore the workflow. Overall, apart from syntactical differences, very little has changed. Checkout the repo, mainly: `/web/` folder and `/lib/migrations`

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Run distributed nodes locally (out of box)

Run each command in two separate terminal tabs:
`bash
PORT=4001 elixir --name n2@127.0.0.1 --erl "-config sys.config" -S mix phoenix.server
elixir --name n1@127.0.0.1 --erl "-config sys.config" -S mix phoenix.server
`

Now, if any node goes down (just ctrl+c twice) you will see in the log the other app gets started automatically after timeout.
