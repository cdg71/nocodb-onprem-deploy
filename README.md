# NocoDB On-Premise Deployment

## Project Overview
This project provides a structured environment to deploy and manage a **NocoDB** instance, along with its dependencies such as PostgreSQL, Redis, MinIO, and cron database dumps. The setup uses Docker Compose for container orchestration and includes scripts for simplified management. Additionally, it includes configuration samples for setting up an Nginx reverse proxy to manage and secure access to the services.

## Project Structure
```
~/
└── nocodb/
   ├── docker-compose.yml    # Docker Compose configuration
   ├── docker.env            # Environment variables for services
   ├── samples/
      ├── nginx/             # Configuration samples for nginx
   ├── scripts/
      ├── cli/               # Scripts for managing services via the command line interface (CLI)
      ├── minio/             # Scripts used by the minio container
      ├── postgres-dumps/    # Scripts used by the postgres-dumps container
   ├── data/                 # Docker bind-mounted directories
   │   ├── minio/            # Minio data
   │   ├── nocodb/           # NocoDB data
   │   ├── postgres/         # PostgreSQL data
   │   ├── postgres-dumps/   # PostgreSQL database dumps
   │   └── redis/            # Redis data
```

## Prerequisites
Ensure the following is installed on your machine:
- **Docker** (includes Docker Compose): [Install Docker](https://docs.docker.com/get-docker/)

## Setup Instructions
### 1. Clone the Repository
```bash
git clone https://github.com/cdg71/nocodb-onprem-deploy
cd nocodb-onprem-deploy
```

### 2. Configure Environment Variables
- Rename the `docker.env.sample` file to `docker.env` and set the appropriate environment variables, such as passwords, keys, domain names and database dumps schedule (use cron syntax).

### 3. Start the Services
Run the following command to start all services:
```bash
./scripts/cli/main.sh
```

Use the menu to:
- Install, update or uninstall the project
- Start, stop, or restart services
- View logs, monitor execution and inspect containers

Alternatively, you can use Docker compose commands directly:
```bash
docker compose up -d
```

### 4. Access NocoDB
- Default NocoDB URL: [http://localhost](http://localhost)
- If MinIO is enabled:
  - API: [http://localhost:9000](http://localhost:9000)
  - Console: [http://localhost:9001](http://localhost:9001)

## Service management cli
The `main.sh` script in the `scripts/cli` directory provides an interactive menu for common tasks:
1. Start / Install
2. Stop
3. Restart
4. Update
5. Logs
6. Monitor
7. Inspect
8. Uninstall

Run the script:
```bash
./scripts/manage.sh
```

## Data Persistence
All persistent data is stored in the `data/` directory:
- **Minio data**: `./data/minio/`
- **NocoDB data**: `./data/nocodb/`
- **PostgreSQL database**: `./data/postgres/`
- **PostgreSQL dumps**: `./data/postgres-dumps/`
- **Redis data**: `./data/redis/`

To back up or restore the project data, simply copy these folders.

## Using Nginx Reverse Proxy Samples
The `samples/` directory contains configuration samples for setting up an Nginx reverse proxy. These samples can be used to secure and manage access to the NocoDB and other services. To use the samples:
1. Copy the desired sample configuration to your Nginx configuration directory.
2. Modify the configuration to match your domain and service ports.
3. Generate the TLS config and certificates using Certbot or any other compatible service.
5. Restart Nginx to apply the changes.

## Troubleshooting

### Common Issues
- **Port Conflicts:** Ensure ports `80`, `9000`, and `9001` are not in use by other applications.
- **Permissions Errors:** Ensure you have proper permissions to run Docker commands or use `sudo`.
