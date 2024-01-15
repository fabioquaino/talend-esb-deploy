# Talend-ESB Runtime (v8.0) with Traefik Configuration

This repository contains the configuration and deployment setup for services using Talend ESB 8 with Traefik as a reverse proxy. Talend ESB is an open-source enterprise service bus platform that allows designing, developing, testing, and deploying integration services and processes.

## Contents

- **talendesb**: Configuration for Talend ESB 8 services, with specific routing using Traefik.
- **traefik**: Configuration for Traefik as a reverse proxy to handle routing and service exposure.

## How It Works

Talend ESB services are configured to run on specific ports, and Traefik is used as a reverse proxy to manage incoming requests. Traefik dynamically updates its configuration based on Docker events, ensuring that the routing rules are always up-to-date.

## Usage Instructions

1. Clone this repository to your development environment.
2. Modify the configuration files (docker-compose.yaml) according to your specific requirements.
3. Use Docker Compose to deploy and manage the services.

```bash
docker-compose up -d
