FROM alpine:3.2

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs \
    libxml2-dev libxslt-dev

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    postgresql-dev libc-dev linux-headers && \
    gem install bundler && \
    cd /app ; bundle config build.nokogiri --use-system-libraries && bundle install --without development test && \
    apk del build-dependencies

ADD . /app
RUN chown -R nobody:nogroup /app
USER nobody

ENV RAILS_ENV production
WORKDIR /app
# shanti token - just here to not make intiializers explode (will not be used in prod)
ENV DEVISE_TOKEN_AUTH_SECRET_KEY foobar
RUN bundle exec rake assets:precompile
CMD ["bundle", "exec", "thin", "-p", "8080", "-l", "log/thin.log", "start"]

