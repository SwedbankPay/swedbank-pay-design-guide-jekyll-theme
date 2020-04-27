FROM ruby:2.7.1

ENV BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG=/usr/local/bundle \
    BUNDLE_HOME=/usr/local/bundle \
    BUNDLE_APP_CONFIG=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin \
    GEM_HOME=/usr/gem
ENV JEKYLL_VAR_DIR=/var/jekyll \
    JEKYLL_VERSION=4.0.0 \
    JEKYLL_DATA_DIR=/srv/jekyll \
    JEKYLL_BIN=/usr/jekyll/bin \
    JEKYLL_ENV=development
ENV PATH=/usr/jekyll/bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV VERBOSE=false
ENV FORCE_POLLING=false
ENV DRAFTS=false

RUN apt-get clean && \
    apt-get update && \
    apt-get \
        --no-install-recommends \
        install -y \
        locales \
        default-jre \
        graphviz \
        fontconfig

RUN echo "Europe/Oslo" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    TZ=Europe/Oslo \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US

RUN unset GEM_HOME \
    && unset GEM_BIN \
    && yes | gem update --system
RUN unset GEM_HOME \
    && unset GEM_BIN \
    && yes | gem install --force bundler
RUN gem install jekyll --version $JEKYLL_VERSION -- --use-system-libraries
RUN gem install \
        html-proofer \
        jekyll-reload \
        jekyll-mentions \
        jekyll-coffeescript \
        jekyll-sass-converter \
        jekyll-commonmark \
        jekyll-paginate \
        jekyll-compose \
        jekyll-assets \
        RedCloth \
        kramdown \
        jemoji \
        jekyll-redirect-from \
        jekyll-sitemap \
        jekyll-feed minima \
        -- --use-system-libraries
RUN addgroup --system --gid 1000 jekyll
RUN adduser --system --gid 1000 jekyll
RUN mkdir -p $JEKYLL_VAR_DIR
RUN mkdir -p $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_VAR_DIR
RUN chown -R jekyll:jekyll $BUNDLE_HOME
RUN rm -rf /root/.gem
RUN rm -rf /home/jekyll/.gem
RUN rm -rf $BUNDLE_HOME/cache
RUN rm -rf $GEM_HOME/cache

WORKDIR /srv/jekyll
COPY . .

ENTRYPOINT [ ".docker/entrypoint" ]

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
