# Inception

Containerized infrastructure project using Docker, developed as part of the 42 School curriculum.

## Overview

The goal of this project is to build a small web infrastructure using **Docker** and **Docker Compose**.
Multiple services run in isolated containers and communicate through a dedicated Docker network.

The architecture typically includes a web server, an application server, and a database, all configured and orchestrated through Docker.

## Tech Stack

* Docker
* Docker Compose
* NGINX
* WordPress
* MariaDB
* Linux

## Architecture

The infrastructure is composed of several containers working together:

* **NGINX** — reverse proxy and HTTPS entry point
* **WordPress** — web application running with PHP-FPM
* **MariaDB** — relational database for WordPress

Each service runs in its own container and communicates through Docker networks while persisting data through volumes.

```mermaid
flowchart LR
    Client --> NGINX
    NGINX --> WordPress
    WordPress --> MariaDB
```

## Learning Outcomes

* Containerization with Docker
* Service orchestration using Docker Compose
* Network communication between containers
* Volume management and data persistence
* Basic infrastructure and deployment concepts
