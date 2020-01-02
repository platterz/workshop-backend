FROM ruby:2.6.5-stretch
COPY . /application
WORKDIR /application
RUN gem install bundler
RUN bundle config set deployment true
RUN bundle config set without 'development test'
RUN bundle install
ENV RAILS_ENV production
EXPOSE 80
CMD bundle exec rails server --port 80