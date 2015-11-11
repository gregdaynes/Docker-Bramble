# Compose Example

A simple demonstation of using multiple compose files to create development and production ready deployments.

This example also shows how to avoid using dockerfiles and building using pre defined images from docker hub.

# Start Development Containers

```bash
docker-compose \
    -p ce \
    -f docker-compose.yml \
    up -d
```

# Start Production Containers

```bash
docker-compose \
    -p ce \
    -f docker-compose.yml \
    -f docker-compose.production.yml \
    up -d
```
