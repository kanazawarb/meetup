FROM ruby:3.1.2

ENV LC_ALL C.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8

RUN useradd -m -u 1000 jekyll
WORKDIR /tmp
ADD . /tmp

RUN chown jekyll -R /tmp && \
    bundle config set system 'true' && \
    bundle install

EXPOSE 4000
USER jekyll
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "-I", "-l"]
