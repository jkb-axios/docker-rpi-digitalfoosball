# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Kipp Bowen <kipp.bowen@axiosengineering.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    python3-pip \
    python-couchdb \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    git \
    ca-certificates \
    ruby \
    rubygems \
    pv \
    libcurl4-gnutls-dev \
    vim \
    nodejs=0.6.19~dfsg1-6 \
    nodejs-dev \
    node-abbrev \
    node-block-stream \
    node-fstream \
    node-graceful-fs \
    node-inherits \
    node-ini \
    node-lru-cache \
    node-minimatch \
    node-mkdirp \
    node-node-uuid \
    node-nopt \
    node-request \
    node-rimraf \
    node-semver \
    node-tar \
    node-which \
    npm \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN source /usr/local/rvm/scripts/rvm && rvm install 1.9.3

RUN gem install rubygems-update \
    json \
    bundler \
    awscli

RUN npm install -g express@3.0.0 \
    mustache@1.0.0 \
    oauth@0.9.12 \
    socket.io@0.8.7

# configure git
RUN git config --global user.email "kipp.bowen@axiosengineering.com"
RUN git config --global user.name "Kipp Bowen"

# pull soca git repo and apply patch, build, install
RUN mkdir -p /data/repos
RUN cd /data/repos && git clone https://github.com/quirkey/soca.git soca
RUN cd /data/repos/soca && git checkout v0.3.3
ADD ./fix_file_read.patch /data/repos/soca/fix_file_read.patch
RUN cd /data/repos/soca && git am --signoff < fix_file_read.patch
RUN cd /data/repos/soca && gem build soca.gemspec
RUN cd /data/repos/soca && gem install soca-*.gem

# pull digitalfoosball repo from github
RUN cd /data/repos && git clone https://github.com/jkb-axios/digitalfoosball.git jkb-digitalfoosball
#RUN cd /data/repos/jkb-digitalfoosball && git checkout latest-configuration

# TODO - configure for digitalfoosball

# Define working directory
WORKDIR /data/repos/jkb-digitalfoosball

# Define default command
CMD ["bash"]
