#!/usr/bin/with-contenv bashio
# ==============================================================================
# Initialize MQTT configuration
# ==============================================================================

if bashio::services.available "mqtt"; then
	bashio::log.info "Setting up MQTT configuration..."

	# Get MQTT settings from Home Assistant services
	MQTT_HOST="$(bashio::services "mqtt" "host")"
	MQTT_PORT="$(bashio::services "mqtt" "port")"
	MQTT_USER="$(bashio::services "mqtt" "username")"
	MQTT_PASS="$(bashio::services "mqtt" "password")"

	# Configure Mosquitto
	{
		echo "listener 1883"
		echo "persistence true"
		echo "persistence_location /data/mosquitto"
		echo "log_dest stdout"

		if [ -n "$MQTT_USER" ] && [ -n "$MQTT_PASS" ]; then
			echo "allow_anonymous false"
			echo "password_file /etc/mosquitto/passwd"
			mosquitto_passwd -b /etc/mosquitto/passwd "$MQTT_USER" "$MQTT_PASS"
		else
			echo "allow_anonymous true"
		fi
	} >/etc/mosquitto/mosquitto.conf

	bashio::log.info "MQTT configuration completed"
else
	bashio::log.warning "MQTT service not available"
fi
