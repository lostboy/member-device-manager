FROM polleverywhere/rbenv
MAINTAINER Paul Crabtree <paul.crabtree@gmail.com>

ENV RUBY_VERSION 2.0.0-p594
ENV RAILS_ENV development

RUN apt-get update -qq
RUN apt-get install -qq -y software-properties-common

RUN apt-get -qq -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev

RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update -qq

RUN apt-get install -qq -y nodejs

RUN rbenv install $RUBY_VERSION
RUN rbenv rehash
RUN rbenv global $RUBY_VERSION

RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -qq
RUN apt-get -qq -y install git libpq-dev postgresql-client 

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

WORKDIR /app

RUN gem install bundler

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app

RUN rm /app/.ruby-version

ENTRYPOINT bundle exec rails s

EXPOSE 3000