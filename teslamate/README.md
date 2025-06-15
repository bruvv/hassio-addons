# Home Assistant Add-on: TeslaMate (All-in-One)

TeslaMate is a powerful, self-hosted data logger for Tesla vehicles. This all-in-one add-on bundles TeslaMate, PostgreSQL, Grafana, and Mosquitto, so you can get started with a single installation.

## Features

- Logs data from your Tesla vehicle(s)
- Bundled PostgreSQL database
- Bundled Grafana dashboards
- Bundled Mosquitto MQTT broker
- Provides a web interface at port 4000 (ingress supported)
- Grafana dashboards at port 3000
- MQTT broker at port 1883
- PostgreSQL at port 5432

## Supported Architectures

- amd64 (x86-64)
- arm64 (aarch64)
- armv7 (32-bit ARM)

## Configuration

**Required options:**

- `database_user`, `database_pass`, `database_name`: Credentials for the bundled PostgreSQL database
- `mqtt_user`, `mqtt_password`: Credentials for the bundled Mosquitto broker (optional, defaults to anonymous)
- `encryption_key`: A secure key to encrypt your Tesla API tokens
- `timezone`/`TZ`: Your local timezone (e.g., `Europe/Amsterdam`)
- `grafana_admin_user`, `grafana_admin_password`: Credentials for the bundled Grafana dashboard

**Example options:**

```yaml
options:
  database_user: teslamate
  database_pass: changeme
  database_name: teslamate
  database_host: localhost
  mqtt_host: localhost
  mqtt_user: your_mqtt_user
  mqtt_password: your_mqtt_password
  encryption_key: your_secure_key
  timezone: Europe/Amsterdam
  TZ: Europe/Amsterdam
  grafana_admin_user: admin
  grafana_admin_password: admin
```

## Access

- TeslaMate web interface: Ingress or `http://[HomeAssistantIP]:4000`
- Grafana dashboards: `http://[HomeAssistantIP]:3000` (default user: as configured)
- PostgreSQL: `localhost:5432` (as configured)
- Mosquitto MQTT: `localhost:1883` (as configured)

## Notes

- All services are started and managed together using s6-overlay.
- Data is stored in the add-on's `/data` directory for persistence.
- You can use the bundled services or connect external clients to the exposed ports.

## References

- [Official TeslaMate Documentation](https://docs.teslamate.org/docs/installation/docker)
- [TeslaMate GitHub](https://github.com/teslamate-org/teslamate)

## Support

For issues, open a ticket in the [bruvv/hassio-addons GitHub repository](https://github.com/bruvv/hassio-addons/issues).
