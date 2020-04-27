FROM ruby:2.7.1-slim

WORKDIR /srv/jekyll
COPY . .

# Ruby env
ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem

# Jekyll
ENV JEKYLL_VAR_DIR=/var/jekyll
ENV JEKYLL_DATA_DIR=/srv/jekyll
ENV JEKYLL_BIN=/usr/jekyll/bin

#RUN addgroup jekyll
#RUN adduser -a -G jekyll jekyll

RUN mkdir -p $JEKYLL_VAR_DIR
RUN mkdir -p $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_VAR_DIR
RUN chown -R jekyll:jekyll $BUNDLE_HOME

RUN apt-get update && \
    apt-get install -y \
    git

RUN unset GEM_HOME && unset GEM_BIN && \
    yes | gem update --system

RUN gem install bundler
RUN bundle install


VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000