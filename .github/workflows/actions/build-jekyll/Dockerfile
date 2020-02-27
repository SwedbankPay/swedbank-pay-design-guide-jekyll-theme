FROM ruby:2-slim
LABEL version="1.0.0"

ENV BUNDLER_VERSION 2.0.2
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  apt-utils \
  bats \
  build-essential \
  ca-certificates \
  curl \
  libffi6 \
  make \
  shellcheck \
  libffi6 \
  git \
  && gem install bundler:2.0.2 \
  && bundle config --global silence_root_warning 1

COPY build.sh /

ENTRYPOINT ["sh", "/build.sh"]