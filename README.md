# Hubud - Device manager


## Requirements

- PostgreSQL running under local user (on OSX install with Homebrew)
- Ruby 2.1.2
- Bundler


## Development

### Git branching model

http://nvie.com/posts/a-successful-git-branching-model/

### Configuration

Make sure you have your Figaro configuration correctly set up. Here's a sample
setup:

```yml
common: &common
  DATABASE_USERNAME: me

test:
  <<: *common
  DEVISE_SECRET: super-secret
  SECRET_KEY_BASE: maybe-even-more-secret

development:
  <<: *common
  DEVISE_SECRET: super-secret
  SECRET_KEY_BASE: maybe-even-more-secret
```

### Database initialization

    $ rake db:migrate
    $ rake db:setup


### Server

With a correct setup, start the server.

    $ bin/rails server


### Specs using RSpec and Guard

    $ bundle exec guard
