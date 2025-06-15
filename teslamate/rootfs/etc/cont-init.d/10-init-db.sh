#!/usr/bin/with-contenv bash
# Initialize PostgreSQL database if needed
if [ ! -d "/var/lib/postgresql/data/base" ]; then
  su - postgres -c "/usr/lib/postgresql/$(psql --version | awk '{print $3}' | cut -d. -f1,2)/bin/initdb -D /var/lib/postgresql/data"
fi
