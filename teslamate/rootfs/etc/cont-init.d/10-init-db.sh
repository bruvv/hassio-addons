#!/usr/bin/with-contenv bashio
# ==============================================================================
# Initialize PostgreSQL database
# ==============================================================================

bashio::log.info "Initializing PostgreSQL database..."

# Check if database is already initialized
if [ ! -d "/data/postgres/base" ]; then
    bashio::log.info "First run detected, initializing PostgreSQL database..."

    # Initialize database
    s6-setuidgid postgres initdb -D /data/postgres

    # Configure PostgreSQL
    {
        echo "listen_addresses = '*'"
        echo "unix_socket_directories = '/var/run/postgresql'"
        echo "log_destination = 'stderr'"
        echo "logging_collector = off"
        echo "max_connections = 100"
    } >> /data/postgres/postgresql.conf

    # Configure authentication
    {
        echo "host all all 0.0.0.0/0 md5"
        echo "local all all trust"
    } > /data/postgres/pg_hba.conf

    # Start PostgreSQL temporarily to create user and database
    s6-setuidgid postgres pg_ctl -D /data/postgres -o "-c listen_addresses='localhost'" -w start

    # Create user and database
    if s6-setuidgid postgres psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
        CREATE USER teslamate WITH PASSWORD 'teslamate';
        CREATE DATABASE teslamate OWNER teslamate;
        GRANT ALL PRIVILEGES ON DATABASE teslamate TO teslamate;
EOSQL
    then
        bashio::log.info "Database and user created successfully"
    else
        bashio::log.error "Failed to create database and user"
        exit 1
    fi

    # Stop PostgreSQL
    s6-setuidgid postgres pg_ctl -D /data/postgres -m fast -w stop
fi

bashio::log.info "PostgreSQL database initialization completed"
