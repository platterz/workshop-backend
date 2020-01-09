#! /bin/bash
bundle exec rails db:create
bundle exec rails db:migrate db:seed
bundle exec rails server --port 80
