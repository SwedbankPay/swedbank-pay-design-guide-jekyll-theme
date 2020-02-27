#!/bin/bash
# Exit immediately if a pipeline returns a non-zero status.
set -e

REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git clone $REMOTE_REPO repo
cd repo

# Install all of our dependencies inside the container
# based on the git repository Gemfile
echo "⚡️ Installing project dependencies..."
bundle install

echo "🏋️ Building website..."
JEKYLL_ENV=production bundle exec jekyll build

cd _site

rm -f README.md

git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .

git commit -m "Github Actions - $(date)"
echo "Build branch ready to go. Pushing to Github..."

git push --force $REMOTE_REPO master:gh-pages
# Now everything is ready.
# Lets just be a good citizen and so some clean-up after ourselves
rm -fr .git
cd ..
rm -rf repo
