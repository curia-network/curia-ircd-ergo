# Curia IRC Server (Ergo)

Modern IRC server for the Curia chat system. This service provides the core IRC protocol implementation with integrated services (NickServ, ChanServ, etc.).

## Features

- **Network Name**: CommonGround
- **Server Name**: irc.curia.network
- **TLS Support**: Port 6697 with server password protection
- **Services**: NickServ, ChanServ, HistServ enabled
- **History**: In-memory message replay (2048 messages per channel)
- **Authentication**: Server password required (only Soju bouncer should connect)

## Environment Variables

- `ERGO_PASS`: Server password for IRC connections (required)
- `ERGO_OPER_PASS`: Operator password for admin commands (optional)
- `TLS_CERT`: TLS certificate in PEM format (optional, will generate self-signed)
- `TLS_KEY`: TLS private key in PEM format (optional, will generate self-signed)

## Ports

- `6667`: Plain IRC (for local development)
- `6697`: TLS IRC (for production)

## Local Development

```bash
# Build the image
docker build -t curia-ergo .

# Run with environment variables
docker run -p 6667:6667 -p 6697:6697 \
  -e ERGO_PASS=devpass123 \
  -e ERGO_OPER_PASS=operpass123 \
  curia-ergo
```

## Production Deployment (Railway)

1. Create a new Railway service from this repository
2. Set the required environment variables in Railway dashboard:
   - `ERGO_PASS`: Strong password for server connections
   - `ERGO_OPER_PASS`: Strong password for operator commands
3. Deploy using Railway's GitHub integration

## Testing

Connect with an IRC client:

```
Server: localhost (dev) or irc.curia.network (prod)
Port: 6667 (plain) or 6697 (TLS)
Password: [value of ERGO_PASS]
```

## Security Notes

- Only the Soju bouncer should connect directly to this server
- Server password (`ERGO_PASS`) prevents unauthorized direct connections
- TLS is required for production deployments
- User registration is disabled (users are managed through Soju/Curia)

## Integration

This server is designed to work with:
- **curia-irc-bouncer**: Soju bouncer for multi-user support
- **curia-irc-client**: The Lounge web client
- **Curia**: Identity and authentication system