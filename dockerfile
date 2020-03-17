FROM jekyll/jekyll:3.8

EXPOSE 4000
EXPOSE 35729

CMD [ "bundle", "exec", "jekyll", "build", "JEKYLL_ENV=production"]
