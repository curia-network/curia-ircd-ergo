#!/bin/sh

# Entrypoint script for Ergo IRC server
# Handles environment variable substitution and TLS setup

echo "Starting Ergo IRC Server..."

# Set default values for environment variables if not provided
export ERGO_PASS=${ERGO_PASS:-"devpass123"}
export ERGO_OPER_PASS=${ERGO_OPER_PASS:-"operpass123"}

# Create TLS directory if it doesn't exist
mkdir -p /ergo/tls

# For development, generate self-signed certificates if they don't exist
if [ ! -f /ergo/tls/fullchain.pem ] || [ ! -f /ergo/tls/privkey.pem ]; then
    echo "Generating self-signed TLS certificates..."
    openssl req -x509 -newkey rsa:4096 -keyout /ergo/tls/privkey.pem -out /ergo/tls/fullchain.pem \
        -days 365 -nodes -subj "/C=US/ST=CA/L=SF/O=CommonGround/CN=irc.curia.network"
    chmod 600 /ergo/tls/privkey.pem
    chmod 644 /ergo/tls/fullchain.pem
fi

# Create database directory
mkdir -p /ergo/db

# Substitute environment variables in the config
envsubst < /ergo/ircd.yaml > /tmp/ircd.yaml && mv /tmp/ircd.yaml /ergo/ircd.yaml

echo "Configuration prepared. Starting Ergo..."

# Execute the command passed to the container
exec "$@"