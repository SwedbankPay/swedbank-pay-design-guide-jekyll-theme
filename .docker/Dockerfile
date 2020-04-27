FROM ruby:2.7.1

WORKDIR /srv/jekyll
COPY . .

# Ruby env
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem


RUN addgroup jekyll && \
    useradd -g jekyll jekyll

RUN mkdir -p /var/jekyll
RUN mkdir -p /srv/jekyll
RUN chown -R jekyll:jekyll /srv/jekyll
RUN chown -R jekyll:jekyll /var/jekyll
RUN chown -R jekyll:jekyll /usr/local/bundle

RUN apt-get update && \
    apt-get install -y \
    git

RUN unset GEM_HOME && unset GEM_BIN && \
    yes | gem update --system

RUN unset GEM_HOME && unset GEM_BIN && yes | gem install --force bundler

RUN bundle install

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000