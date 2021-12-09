FROM ruby:2.7.2 as builder

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages.
RUN apt update -qq
RUN apt install -y nodejs yarn

RUN gem install bundler -v 2.1.4

RUN bundle config silence_root_warning 1

ENV APP_ROOT /app_root
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT
RUN bundle install -j4

ADD package.json $APP_ROOT
ADD yarn.lock $APP_ROOT
RUN yarn

ADD . $APP_ROOT
