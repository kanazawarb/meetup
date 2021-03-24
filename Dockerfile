FROM ruby:2.7.2

RUN useradd -m -u 1000 jekyll
WORKDIR /tmp
ADD . /tmp

RUN chown jekyll -R /tmp && \
    bundle config set system 'true' && \
    bundle install && \
    bundle binstubs rake --path /tmp/.bundle/bin --force

EXPOSE 4000
USER jekyll
CMD [".bundle/bin/rake", "serve"]
