#!/usr/bin/with-contenv bash
# Initialize Grafana admin user
if [ ! -d "/var/lib/grafana" ]; then
	mkdir -p /var/lib/grafana
fi
chown -R grafana:grafana /var/lib/grafana
