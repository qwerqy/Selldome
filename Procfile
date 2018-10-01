web: bundle exec rails server -p $PORT
worker:  RAILS_MAX_THREADS=${SIDEKIQ_RAILS_MAX_THREADS:-25} bundle exec sidekiq -q default -q mailers
tail: -f log/development.log
