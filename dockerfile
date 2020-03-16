FROM jekyll/jekyll:3.8

WORKDIR /home/jekyll
COPY . /home/jekyll

RUN apk add \
  graphviz \
  openjdk8-jre-base \
  fontconfig \
  ttf-dejavu

EXPOSE 4000
EXPOSE 35729

ENV BUNDLE_PATH /home/bundle-cache && \
    mkdir /home/bundle-cache && \
    chmod 755 /home/bundle-cache && \
    gem install bundler && \
    bundle check || bundle install

CMD [ "bundle", "exec", "jekyll", "build", "JEKYLL_ENV=production"]
