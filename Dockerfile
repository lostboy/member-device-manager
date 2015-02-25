FROM polleverywhere/rbenv
MAINTAINER Paul Crabtree <paul.crabtree@gmail.com>

ENV RUBY_VERSION 2.0.0-p594
ENV RAILS_ENV development

# install software-properties-common for add-apt-repository
RUN apt-get update -qq
RUN apt-get install -qq -y software-properties-common

# install ruby
RUN apt-get -qq -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev

RUN add-apt-repository -y ppa:chris-lea/node.js
# RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -qq

# install nodejs
RUN apt-get install -qq -y nodejs

RUN rbenv install $RUBY_VERSION
RUN rbenv rehash
RUN rbenv global $RUBY_VERSION

RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -qq
RUN apt-get -qq -y install git libpq-dev postgresql-client 
# libpq5

# RUN apt-get purge -y -qq autoconf bison build-essential libssl-dev zlib1g-dev
# RUN apt-get autoremove -y
# RUN rm -rf /var/lib/apt/lists

# install Nginx.
# RUN apt-get install -qq -y nginx
# RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
# RUN chown -R www-data:www-data /var/lib/nginx
# Add default nginx config
# ADD config/nginx-sites.conf /etc/nginx/sites-enabled/default

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

# Install foreman
# RUN gem install foreman

# Rails App directory
WORKDIR /app

# Add default unicorn config
# ADD config/unicorn.rb /app/config/unicorn.rb

# Add default foreman config
# ADD Procfile /app/Procfile

# CMD bundle exec foreman start -f Procfile
# CMD bundle exec rake assets:precompile && foreman start -f Procfile

# RUN adduser --disabled-password --home=/rails --gecos "" rails
# RUN useradd -ms /bin/bash rails
# USER rails
 
# ENV GEM_HOME /ruby_gems/2.0

RUN gem install bundler

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app

CMD rm /app/.ruby-version

ENTRYPOINT bundle exec rails s

EXPOSE 3000