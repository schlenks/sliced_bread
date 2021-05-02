FROM crystallang/crystal:1.0.0
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /data
EXPOSE 3001
EXPOSE 5000

RUN apt-get update \
  # curl for downloads, tmux required for Overmind
  && apt-get install -y curl tmux libnss3 libgconf-2-4 chromium-browser libreadline-dev golang-go postgresql postgresql-contrib locales \
  # Overmind
  && curl -L -O https://github.com/DarthSim/overmind/releases/download/v2.0.1/overmind-v2.0.1-linux-amd64.gz \
  && gunzip overmind-v2.0.1-linux-amd64.gz \
  && mv overmind-v2.0.1-linux-amd64 /usr/local/bin/overmind \
  && chmod +x /usr/local/bin/overmind \
  # Set up node and yarn
  && curl --silent --location https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn \
  # Lucky cli
  && git clone https://github.com/luckyframework/lucky_cli --branch master --depth 1 /usr/local/lucky_cli \
  && cd /usr/local/lucky_cli \
  && shards install \
  && crystal build src/lucky.cr -o /usr/local/bin/lucky \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8

# Install shards
COPY shard.* ./
RUN shards install

# Install node_modules
COPY package.json .
RUN yarn install

COPY . /data
