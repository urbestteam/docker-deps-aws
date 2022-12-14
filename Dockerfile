FROM clojure:temurin-17-tools-deps-1.11.1.1200-bullseye-slim

# NOTE: jq is only needed for deploy-stage script on z-frontend
# TODO: remove jq when deploy deploy-stage script is removed
RUN apt-get update &&\
    apt-get install curl unzip ca-certificates gnupg lsb-release build-essential jq -y

# taken from https://docs.docker.com/engine/install/debian/
RUN mkdir -p /etc/apt/keyrings &&\
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&\
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
    apt-get update &&\
    VERSION_STRING=5:20.10.21~3-0~debian-bullseye &&\
    apt-get install -y docker-ce-cli=$VERSION_STRING

# taken from https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - &&\
    apt-get install -y nodejs &&\
    corepack enable &&\
    corepack prepare yarn@v1.22.19 --activate

# taken from https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install &&\
    rm awscliv2.zip &&\
    rm -r aws

ENTRYPOINT []
