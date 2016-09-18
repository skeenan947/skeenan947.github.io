#!/bin/bash
cd ~skeenan/skeenan947.github.io/site
git pull
bundle install
bundle exec jekyll b -d /var/www/skeenan/
