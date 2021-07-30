FROM ruby:3.0.2

RUN useradd -m -u 1000 jekyll
WORKDIR /tmp
ADD . /tmp

RUN chown jekyll -R /tmp && \
    bundle config set system 'true' && \
    bundle install

EXPOSE 4000
USER jekyll
CMD ["bundle", "exec", "rake", "serve"]
