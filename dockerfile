FROM jekyll/jekyll:3.8

WORKDIR /home/jekyll
COPY . /home/jekyll

RUN apk add \
    graphviz \
    openjdk8-jre-base \
    fontconfig \
    ttf-dejavu

# Make files writable before bundle install. Se the following issue for more
# details:
# https://github.com/instructure/canvas-lms/issues/1221#issuecomment-362690811

ENV BUNDLE_PATH /home/bundle-cache
RUN mkdir /home/bundle-cache && \
    chmod -R a+w /home/bundle-cache && \
    mkdir .bundle && \
    chmod -R a+w .bundle && \
    gem install bundler && \
    bundle package --all

EXPOSE 4000
EXPOSE 35729

CMD [ "bundle", "exec", "jekyll", "build", "JEKYLL_ENV=production"]
