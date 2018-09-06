#!/bin/bash

# release_ctl eval --mfa "MyApp.ReleaseTasks.migrate/1" -- "$@"
release_ctl eval --mf "Sugarlogapp.ReleaseTasks" -- "$@"
