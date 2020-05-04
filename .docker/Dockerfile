FROM jekyll/jekyll:3.8.6

COPY . .

RUN apk add --no-cache --no-progress\
    graphviz\
    openjdk8-jre-base\
    fontconfig\
    ttf-dejavu

RUN gem install bundler
