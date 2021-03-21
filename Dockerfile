FROM ruby:2.7.2
# RUN mkdir /tmp
ADD . /tmp
WORKDIR /tmp
RUN bundle install
