# Dockerfile for Ergo IRC Server
FROM ergochat/ergo:latest

# Copy configuration file to expected location
COPY ircd.yaml /ircd/ircd.yaml

# Expose IRC ports
EXPOSE 6667 6697

# Use the official image's default entrypoint (run.sh)