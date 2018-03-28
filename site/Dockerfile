FROM ruby:2.3 as jekyll

ADD . /src
WORKDIR /src
RUN mkdir /_site && bundle install && \
bundle exec jekyll build -d /_site

FROM nginx:stable-alpine
COPY --from=jekyll /_site /usr/share/nginx/html/
