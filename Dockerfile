FROM ruby:2.6.3
RUN mkdir /shop_opening_hours
WORKDIR /shop_opening_hours
COPY Gemfile /shop_opening_hours/Gemfile
COPY Gemfile.lock /shop_opening_hours/Gemfile.lock
# RUN bundle update
RUN gem install bundler
RUN bundle install
COPY . /shop_opening_hours
