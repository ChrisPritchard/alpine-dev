FROM alpine:latest@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

# Install ALL tools (build + runtime)
RUN apk add --no-cache \
    # Core tools
    build-base \
    clang \
    llvm \
    lld \
    cmake \
    git \
    curl \
    tar \
    gzip \
    perl \
    bash \
    sudo \
    # Networking/spoofing
    libpcap \
    libpcap-dev \
    libnet \
    libnet-dev \
    tcpdump \
    iproute2 \
    nmap \
    openssl \
    openssl-dev \
    linux-headers \
    busybox-extras \
    # Editors
    nano \
    vim \
    # Go dependencies
    go \
    # Rust dependencies
    cargo \
    rust \
    rust-stdlib \
    musl-dev \
    gcompat \
    # For build minimisation
    upx

# Install latest Go manually (apk version may be outdated)
ENV GO_VERSION=1.21.0
RUN curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xzf -
ENV PATH=/usr/local/go/bin:$PATH

# Install latest Rust via rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup target add x86_64-unknown-linux-musl

# Configure clang as default compiler
ENV CC=clang \
    CXX=clang++ \
    RUSTFLAGS="-C linker=clang -C link-arg=-fuse-ld=lld" \
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C linker=clang -C link-arg=-fuse-ld=lld"

WORKDIR /workspace
CMD ["/bin/sh"]