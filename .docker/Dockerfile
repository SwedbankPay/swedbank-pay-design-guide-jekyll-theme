FROM ruby:2.7.1

WORKDIR /srv/jekyll
COPY . .

RUN addgroup jekyll && \
    useradd -g jekyll jekyll

RUN mkdir -p /var/jekyll
RUN mkdir -p /srv/jekyll
RUN chown -R jekyll:jekyll /srv/jekyll
RUN chown -R jekyll:jekyll /var/jekyll
RUN chown -R jekyll:jekyll /usr/local/bundle

RUN apt-get update && \
    apt-get install -y \
    git

RUN unset /usr/local/bundle && unset /usr/gem/bin && \
    yes | gem update --system

RUN unset /usr/local/bundle && unset /usr/gem/bin && yes | gem install --force bundler

RUN bundle install

RUN bundle check

ENTRYPOINT [ "bundle", "exec" ]

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000