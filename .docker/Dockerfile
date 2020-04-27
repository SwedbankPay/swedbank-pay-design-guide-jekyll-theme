FROM ruby:2.7.1

ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1 BUNDLE_APP_CONFIG=/usr/local/bundle
ENV PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem
ENV JEKYLL_VAR_DIR=/var/jekyll
ENV JEKYLL_DOCKER_TAG=4.0.0
ENV JEKYLL_VERSION=4.0.0
ENV JEKYLL_DOCKER_COMMIT=d567ca8e579ba0798a1a1137f3aab0fd06a75fb6
ENV JEKYLL_DOCKER_NAME=jekyll
ENV JEKYLL_DATA_DIR=/srv/jekyll
ENV JEKYLL_BIN=/usr/jekyll/bin
ENV JEKYLL_ENV=development
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=America/Chicago
ENV PATH=/usr/jekyll/bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US
ENV VERBOSE=false
ENV FORCE_POLLING=false
ENV DRAFTS=false

RUN /bin/sh -c unset GEM_HOME \
    && unset GEM_BIN \
    &&   yes | gem update --system
RUN /bin/sh -c unset GEM_HOME \
    && unset GEM_BIN \
    && yes | gem install --force bundler
RUN /bin/sh -c gem install jekyll -v4.0.0 --     --use-system-libraries
RUN /bin/sh -c gem install html-proofer jekyll-reload jekyll-mentions jekyll-coffeescript jekyll-sass-converter jekyll-commonmark jekyll-paginate jekyll-compose jekyll-assets RedCloth kramdown jemoji jekyll-redirect-from jekyll-sitemap jekyll-feed minima --     --use-system-libraries
RUN /bin/sh -c addgroup -Sg 1000 jekyll
RUN /bin/sh -c adduser  -Su 1000 -G   jekyll jekyll
RUN /bin/sh -c mkdir -p $JEKYLL_VAR_DIR
RUN /bin/sh -c mkdir -p $JEKYLL_DATA_DIR
RUN /bin/sh -c chown -R jekyll:jekyll $JEKYLL_DATA_DIR
RUN /bin/sh -c chown -R jekyll:jekyll $JEKYLL_VAR_DIR
RUN /bin/sh -c chown -R jekyll:jekyll $BUNDLE_HOME
RUN /bin/sh -c rm -rf /root/.gem
RUN /bin/sh -c rm -rf /home/jekyll/.gem
RUN /bin/sh -c rm -rf $BUNDLE_HOME/cache
RUN /bin/sh -c rm -rf $GEM_HOME/cache

WORKDIR /srv/jekyll
COPY . .

RUN addgroup jekyll && \
    useradd -g jekyll jekyll

ENTRYPOINT [ ".docker/entrypoint" ]

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000