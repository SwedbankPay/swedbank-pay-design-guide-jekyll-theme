FROM jekyll/jekyll:4.0.0

WORKDIR /srv/jekyll
VOLUME  /srv/jekyll

RUN mkdir -p /var/jekyll && \
    mkdir -p /srv/jekyll && \
    mkdir -p /srv/jekyll/_site && \
    mkdir -p /usr/gem/cache && \
    mkdir -p /srv/jekyll/.jekyll-cache

RUN apk add --no-cache --no-progress\
    graphviz\
    openjdk8-jre-base\
    fontconfig\
    ttf-dejavu

COPY . .

# Work around a nonsense RubyGem permission bug.
RUN unset GEM_HOME && unset GEM_BIN && yes | gem install --force bundler
RUN bundle config set no-cache 'true' && \
    bundle config path /srv/jekyll/.gems && \
    bundle install --jobs $(($(nproc) * 2))

CMD ["jekyll", "--help"]
ENTRYPOINT [ ".docker/ci-build-publish" ]
