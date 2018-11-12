# proxy-nifi-docker
An example of several proxies in front of Apache NiFi, all running in docker containers.

_Note: Please use Chrome when testing the proxies.  Hostnames are in the .localhost domain which is handled explicitly by Chrome._

# Build the NiFi dockermaven image
1. `mvn clean install -Pcontrib-check`
1. `mvn install -pl nifi-docker/dockermaven/pom.xml -Pdocker`  
1. `docker images`  
  Confirm the NiFi 1.9.0-SNAPSHOT docker image exists:
    ```
    $ docker images
    REPOSITORY             TAG                          IMAGE ID            CREATED             SIZE
    apache/nifi            1.9.0-SNAPSHOT-dockermaven   119e30c23439        5 minutes ago       1.82GB
    ```
# Starting the containers
- `./scripts/start.sh`

# Watching the logs
- `docker-compose -f knox-dev-docker/docker-compose.yml logs -f`
- `docker-compose -f docker-compose-anonymous-nifi.yaml logs -f`

# Accessing NiFi
- NiFi is available
  - on the host at: http://localhost:9090/nifi/
  - through Traefik at: http://nifi.docker.localhost/traefik/nifi/
  - through Knox at: https://localhost:8443/gateway/nifi/nifi-app/nifi/
  - through Nginx at: http://nginx.docker.localhost:8081/nifi/

# Verifying proxy functionality
1. Go to url: http://nifi.docker.localhost/traefik/nifi/  
  Traefik uses X-Forwarded-Host/X-Forwarded-Prefix:
    1. Add several processors and connect them
    1. Verify that the processors can be moved on the canvas
    1. Open the processor configuration for any of the processors
    1. View Usage for any of the processors on the canvas
1. Go to url: https://localhost:8443/gateway/nifi/nifi-app/nifi  
  Knox uses X-Forwarded-Host/X-Forwarded-Context:
    1. Add several processors and connect them
    1. Verify that the processors can be moved on the canvas
    1. Open the processor configuration for any of the processors
    1. View Usage for any of the processors on the canvas
1. Go to url: http://nginx.docker.localhost:8081/nifi/  
  Nginx is configured to use X-ProxyHost/X-ProxyContextPath:
    1. Add several processors and connect them
    1. Verify that the processors can be moved on the canvas
    1. Open the processor configuration for any of the processors
    1. View Usage for any of the processors on the canvas

# Stopping the containers
- `./scripts/stop.sh`
