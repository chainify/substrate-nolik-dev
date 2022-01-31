FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt install -y cmake pkg-config libssl-dev git build-essential clang libclang-dev curl
RUN apt-get update

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup default stable
RUN rustup update
RUN rustup update nightly
RUN rustup target add wasm32-unknown-unknown --toolchain nightly

WORKDIR /opt
COPY . .
RUN cargo build --release

EXPOSE 9944
