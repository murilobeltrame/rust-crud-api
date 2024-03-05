FROM rust:1.76 AS builder

WORKDIR /app
# Accept the build argument
ARG DATABASE_URL

# Make sure to use the ARG in ENV
ENV DATABASE_URL=$DATABASE_URL

# Copy the source code
COPY . .

# Build the application
RUN cargo build --release

FROM debian:bookworm

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD [ "./rust-crud-api" ]
