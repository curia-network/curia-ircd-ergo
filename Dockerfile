# Dockerfile for Ergo IRC Server
FROM ergochat/ergo:latest

# Copy configuration file directly
COPY ircd.yaml /ircd.yaml

# Expose IRC ports
EXPOSE 6667 6697

# Use default ergo entrypoint with our config
CMD ["ergo", "run", "--conf", "/ircd.yaml"]