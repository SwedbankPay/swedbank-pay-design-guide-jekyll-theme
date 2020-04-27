FROM ruby:2.7.1

WORKDIR /srv/jekyll
COPY . .

RUN addgroup jekyll && \
    useradd -g jekyll jekyll

ENTRYPOINT [ ".docker/entrypoint" ]

VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000