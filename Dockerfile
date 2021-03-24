FROM ruby:2.7.2

WORKDIR /tmp
ADD . /tmp

RUN bundle install && \
    bundle binstubs rake --path /tmp/.bundle/bin --force

EXPOSE 4000
CMD [".bundle/bin/rake", "serve"]
