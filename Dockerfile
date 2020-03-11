FROM ruby:2.7

RUN apt-get update && apt-get install -y \
  libfontconfig \
  graphviz \
  gcc \
  bash \
  cmake \
  git

RUN bundle install

EXPOSE 4000

WORKDIR /site

ENTRYPOINT [ "bundle", "exec", "jekyll" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]