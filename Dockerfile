FROM ruby:alpine

WORKDIR /
COPY *.rb /

ENTRYPOINT [ "ruby", "main.rb", "file" ]