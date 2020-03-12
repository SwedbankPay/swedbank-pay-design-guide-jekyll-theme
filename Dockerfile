FROM ruby:2.7

RUN gem install bundler
RUN apt-get update && apt-get install -y \
  libfontconfig \
  graphviz \
  gcc \
  bash \
  cmake \
  git

COPY . /srv/jekyll
WORKDIR /srv/jekyll

RUN bundle install

EXPOSE 4000

ENTRYPOINT [ "bundle", "exec", "jekyll", "serve" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--trace"]