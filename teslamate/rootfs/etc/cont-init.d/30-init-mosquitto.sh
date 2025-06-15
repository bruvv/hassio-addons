#!/usr/bin/with-contenv bash
# Ensure Mosquitto config exists
if [ ! -f /etc/mosquitto/mosquitto.conf ]; then
	mkdir -p /etc/mosquitto
	echo "allow_anonymous true" >/etc/mosquitto/mosquitto.conf
fi
