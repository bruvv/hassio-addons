#============================#
#  TESLAMATE ALL-IN-ONE ADDON DOCKERFILE  #
#============================#
#=== Home Assistant Addon ===#

ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system dependencies
RUN \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        postgresql-13 \
        postgresql-client-13 \
        wget \
        curl \
        gnupg2 \
        apt-transport-https \
        software-properties-common \
        ca-certificates \
        python3 \
        python3-pip \
        jq \
        tzdata \
    && wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - \
    && echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        grafana \
        mosquitto \
        mosquitto-clients \
    && mkdir -p /data/postgres /data/grafana /data/mosquitto \
    && chown -R grafana:grafana /data/grafana \
    && chown -R mosquitto:mosquitto /data/mosquitto \
    && chown -R postgres:postgres /data/postgres \
    && rm -rf /var/lib/apt/lists/*

# Install TeslaMate
ARG TESLAMATE_VERSION=1.28.4
RUN \
    wget https://github.com/teslamate-org/teslamate/releases/download/v${TESLAMATE_VERSION}/teslamate-linux-x64-${TESLAMATE_VERSION}.tar.gz \
    && tar xf teslamate-linux-x64-${TESLAMATE_VERSION}.tar.gz \
    && mv teslamate /opt/teslamate \
    && rm teslamate-linux-x64-${TESLAMATE_VERSION}.tar.gz

# Create required users
RUN \
    addgroup --system teslamate \
    && adduser --system --home /var/lib/teslamate --disabled-login --ingroup teslamate teslamate

# Create required directories
RUN \
    mkdir -p /data/postgres /data/grafana /data/mosquitto \
    && chown -R teslamate:teslamate /opt/teslamate \
    && chown -R postgres:postgres /data/postgres \
    && chown -R grafana:grafana /data/grafana \
    && chown -R mosquitto:mosquitto /data/mosquitto

# Set up volumes for persistence
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
    MQTT_PORT=1883

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
