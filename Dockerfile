FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Add i386 architecture for 32-bit libraries
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
        build-essential \
        gcc \
        make \
        gcc-multilib \
        execstack \
        libssl-dev:i386 \
        libsodium-dev:i386 \
        wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY build/ /build/

# Build the binary
RUN make build && make post

CMD ["/bin/bash"]
