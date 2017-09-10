FROM ubuntu:latest

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    mono-complete \
    python3 \
    python3-pip \
    python3-setuptools \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install gitsemver
ADD https://downloads.haprotec.de/gitsemver/gitsemver.deb /
RUN dpkg -i ./gitsemver.deb && rm gitsemver.deb

# Add haprotec Python library
RUN cd /usr/local/lib && \
    git clone https://gitlab.com/haprotec/haprotec-python-lib.git && \
    pip3 install -e ./haprotec-python-lib && \
    cd /

# Install create-deb-package
ADD https://downloads.haprotec.de/create-deb-package/create-deb-package.deb /
RUN dpkg -i ./create-deb-package.deb && rm create-deb-package.deb
