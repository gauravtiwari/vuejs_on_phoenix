ExUnit.start

Mix.Task.run "ecto.create", ~w(-r VuejsOnPhoenix.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r VuejsOnPhoenix.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(VuejsOnPhoenix.Repo)

