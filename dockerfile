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

ENV BUNDLE_PATH '/usr/local/bundle'
#RUN bundle config set path '/usr/local/bundle'
RUN gem install bundler
RUN bundle install

CMD [ "bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]