FROM ruby:2.7.1

# app location
ENV APP /app

RUN apt-get update -y \
    && apt-get install -y apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    curl \
    git \
    unzip

RUN curl https://deb.nodesource.com/setup_12.x | bash -
# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y nodejs yarn postgresql-client

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

WORKDIR $APP

ENV BUNDLER_VERSION=2.1.4
RUN gem install bundler:2.1.4

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]