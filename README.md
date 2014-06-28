# Hubud - Device manager


## Requirements

- PostgreSQL running under local user (on OSX install with Homebrew)
- Ruby 2.1.2
- Bundler


## Development

### Git branching model

http://nvie.com/posts/a-successful-git-branching-model/

### Database initialization

    $ rake db:migrate
    $ rake db:setup


### Run development server

    $ rails server


## Specs using RSpec and Guard

    $ bundle exec guard
