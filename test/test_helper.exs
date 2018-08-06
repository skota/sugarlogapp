#  add hound for integration testing
# https://github.com/HashNuke/hound
Application.ensure_all_started(:hound)
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Sugarlogapp.Repo, :manual)

