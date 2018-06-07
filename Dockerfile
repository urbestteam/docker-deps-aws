FROM openjdk:10

ENV CLOJURE_VERSION=1.9.0.381

WORKDIR /tmp

RUN wget https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh \
    && chmod +x linux-install-$CLOJURE_VERSION.sh \
    && ./linux-install-$CLOJURE_VERSION.sh

RUN clojure -e "(clojure-version)"

WORKDIR /opt/urbest

# install aws and jq
RUN apt-get update; \
    apt-get -y --no-install-recommends install ca-certificates \
    # Install Python3 and pip
    python3 python3-setuptools \
    # Install jq
    jq; \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python; \
    # Install awscli
    pip install --upgrade pip; \
    pip install awscli

# install docker
ENV DOCKER_VERSION=17.06.0-ce
RUN curl -L -o /tmp/docker-${DOCKER_VERSION}.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
    tar -xz -C /tmp -f /tmp/docker-${DOCKER_VERSION}.tgz; \
    mv /tmp/docker/* /usr/bin; \
    rm /tmp/docker-${DOCKER_VERSION}.tgz; \
    rm -rf /tmp/docker

