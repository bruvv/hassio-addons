#============================#
#  TESLAMATE ALL-IN-ONE ADDON DOCKERFILE  #
#============================#
#=== Home Assistant Addon ===#

ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install PostgreSQL, Grafana, Mosquitto
RUN \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        postgresql \
        grafana \
        mosquitto \
        mosquitto-clients \
    && rm -rf /var/lib/apt/lists/*

# S6 overlay environment
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# Copy s6 service definitions
COPY rootfs/ /

# Expose all required ports
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
