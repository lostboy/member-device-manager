# web: bundle exec unicorn 
redis: redis-server
web: bundle exec unicorn -c ./config/unicorn.rb
worker: bundle exec sidekiq -c 4 -q nexudus
clock: bundle exec clockwork config/clock.rb