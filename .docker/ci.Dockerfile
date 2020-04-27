FROM jekyll/jekyll:4.0.0

WORKDIR /srv/jekyll
VOLUME  /srv/jekyll

RUN mkdir -p /var/jekyll && \
    mkdir -p /srv/jekyll && \
    mkdir -p /srv/jekyll/_site && \
    mkdir -p /srv/jekyll/.jekyll-cache

RUN apk add --no-cache --no-progress\
    graphviz\
    openjdk8-jre-base\
    fontconfig\
    ttf-dejavu

COPY . .

# Work around a nonsense RubyGem permission bug.
# RUN unset GEM_HOME && unset GEM_BIN && yes |
RUN gem install --force bundler && \
    #bundle config no-cache 'true' && \
    #bundle config path 'vendor/bundle' && \
    bundle install --deployment --jobs $(($(nproc) * 2)) && \
    #bundle check && \
    chown jekyll:jekyll -R /usr/gem && \
    bundle exec jekyll build JEKYLL_ENV=$JEKYLL_ENV --verbose

CMD ["jekyll", "--help"]
ENTRYPOINT [ ".docker/ci-build-publish" ]
