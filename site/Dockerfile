FROM ruby:2.3
VOLUME /_site

CMD git clone https://github.com/skeenan947/skeenan.net.git /src && \
cd /src/site && \
bundle install && \
bundle exec jekyll build -d /_site

