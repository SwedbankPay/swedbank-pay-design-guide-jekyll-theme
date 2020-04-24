FROM jekyll/jekyll:4.0.0

RUN apk add --no-progress\
    graphviz\
    openjdk8-jre-base\
    fontconfig\
    ttf-dejavu

COPY . /

RUN mkdir -p /var/jekyll
RUN mkdir -p /srv/jekyll
RUN chown -R jekyll:jekyll /srv/jekyll
RUN chown -R jekyll:jekyll /usr/jekyll/bin
RUN chown -R jekyll:jekyll /usr/local/bundle

# Work around a nonsense RubyGem permission bug.
RUN unset GEM_HOME && unset GEM_BIN && yes | gem install --force bundler
RUN bundle install

CMD ["jekyll", "--help"]
ENTRYPOINT [ ".docker/ci-build-publish" ]
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
