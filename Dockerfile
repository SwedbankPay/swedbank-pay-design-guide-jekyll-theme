FROM ruby:2.7

COPY . /srv/jekyll
WORKDIR /srv/jekyll

RUN gem install bundler
RUN apt-get update && apt-get install -y \
  libfontconfig \
  graphviz \
  gcc \
  bash \
  cmake \
  git


RUN bundle install

EXPOSE 4000

ENTRYPOINT [ "bundle", "exec", "jekyll", "serve" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--trace"]