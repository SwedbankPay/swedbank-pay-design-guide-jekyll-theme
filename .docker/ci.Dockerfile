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

FROM swedbankpay/jekyll-plantuml:1.1.1

CMD [ "jekyll" ]
ENTRYPOINT [ ".docker/ci-build-publish" ]