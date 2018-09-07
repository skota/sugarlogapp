#!/bin/bash

# release_ctl eval --mfa "MyApp.ReleaseTasks.migrate/1" -- "$@"
bin/sugarlogapp command Elixir.Sugarlogapp.ReleaseTasks migrate_db
