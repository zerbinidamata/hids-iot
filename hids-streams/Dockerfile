FROM rust:slim-buster

RUN USER=root cargo new --bin hids-streams
WORKDIR /hids-streams

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# Build only the dependencies to cache them
RUN cargo build --release
RUN rm src/*.rs

# Now that the dependency is built, copy your source code
COPY ./src ./src

RUN rm ./target/release/deps/hids-streams*
RUN cargo install --path .

CMD ["hids-streams"]