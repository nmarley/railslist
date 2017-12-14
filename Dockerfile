FROM alpine:3.5

RUN echo 'set -o vi' >> /etc/profile
RUN echo 'gem: --no-document' > /etc/gemrc

RUN apk update && apk upgrade && \
    apk add --no-cache bash alpine-sdk ruby ruby-dev ruby-io-console ruby-irb ruby-bigdecimal ruby-json libstdc++ tzdata bash ca-certificates && \
    rm -fr /var/cache/apk/*

WORKDIR /app

# Copy Gemfile separate to avoid rebuilding layer for every file change
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle config --global silence_root_warning 1
RUN bundle install --path vendor

COPY . /app

EXPOSE 4567

CMD ["/usr/bin/bundle", "exec", "puma", "-C", "config/puma.rb", "config.ru"]
