#============================#
#  TESLAMATE ALL-IN-ONE ADDON DOCKERFILE  #
#============================#
#=== Home Assistant Addon ===#

##################
# 1 Build Images #
##################

# Build arguments
ARG BUILD_FROM
ARG BUILD_VERSION
ARG TESLAMATE_VERSION=${BUILD_VERSION}

# Multi-stage builds
FROM postgres:13-alpine AS postgres
FROM grafana/grafana:latest AS grafana
FROM eclipse-mosquitto:2 AS mosquitto
FROM ghcr.io/teslamate-org/teslamate:v${TESLAMATE_VERSION} AS teslamate

##################
# 2 Final Image  #
##################

# Build final image
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy files from other containers
COPY --from=teslamate /opt/app /opt/teslamate
COPY --from=grafana /usr/share/grafana /usr/share/grafana
COPY --from=mosquitto /usr/sbin/mosquitto /usr/sbin/mosquitto
COPY --from=postgres /usr/local/bin/postgres /usr/local/bin/postgres

# Switch to root user for directory creation
USER root

# Create data directories with proper permissions
RUN mkdir -p \
    /data/postgres \
    /data/grafana \
    /data/mosquitto && \
    chown -R root:root /data && \
    chmod -R 755 /data

# Set volumes
VOLUME ["/data/postgres", "/data/grafana", "/data/mosquitto"]

# S6 overlay environment
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# Copy s6 service definitions
COPY rootfs/ /

# Environment variables for services
ENV \
    POSTGRES_DB=teslamate \
    POSTGRES_USER=teslamate \
    POSTGRES_PASSWORD=teslamate \
    GRAFANA_ADMIN_PASSWORD=admin \
    DATABASE_USER=teslamate \
    DATABASE_PASS=teslamate \
    DATABASE_NAME=teslamate \
    DATABASE_HOST=localhost \
    MQTT_HOST=localhost \
    MQTT_PORT=1883 \
    PATH="/usr/share/grafana/bin:${PATH}" \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/data/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

# Expose all required ports
# 4000: TeslaMate Web UI
# 3000: Grafana
# 5432: PostgreSQL
# 1883: MQTT
EXPOSE 4000 3000 5432 1883

# Labels
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ENV BUILD_VERSION="${BUILD_VERSION}"
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="bruvv" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant TeslaMate Addon" \
    org.opencontainers.image.authors="bruvv" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/bruvv/hassio-addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Start all services with s6
CMD ["/init"]
