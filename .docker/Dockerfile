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

RUN unset GEM_HOME \
    && unset GEM_BIN \
    &&   yes | gem update --system
RUN unset GEM_HOME \
    && unset GEM_BIN \
    && yes | gem install --force bundler
RUN gem install jekyll --version 4.0.0 -- --use-system-libraries
RUN gem install html-proofer jekyll-reload jekyll-mentions jekyll-coffeescript jekyll-sass-converter jekyll-commonmark jekyll-paginate jekyll-compose jekyll-assets RedCloth kramdown jemoji jekyll-redirect-from jekyll-sitemap jekyll-feed minima -- --use-system-libraries
RUN addgroup --system -gid 1000 jekyll
RUN adduser --system --gid 1000 jekyll jekyll
RUN mkdir -p $JEKYLL_VAR_DIR
RUN mkdir -p $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_VAR_DIR
RUN chown -R jekyll:jekyll $BUNDLE_HOME
RUN rm -rf /root/.gem
RUN rm -rf /home/jekyll/.gem
RUN rm -rf $BUNDLE_HOME/cache
RUN rm -rf $GEM_HOME/cache

RUN apt install default-jre

WORKDIR /srv/jekyll
COPY . .

RUN addgroup jekyll && \
    useradd -g jekyll jekyll

ENTRYPOINT [ ".docker/entrypoint" ]

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
