# TeslaMate Home Assistant Add-on Documentation

## Overview

TeslaMate is a powerful data logger and visualization tool for your Tesla vehicle. This add-on provides an all-in-one solution with optional bundled PostgreSQL, Grafana, and MQTT integration for maximum compatibility with Home Assistant.

## Installation

1. Add this repository to your Home Assistant instance.
2. Install the TeslaMate add-on.
3. Configure the required settings (see Configuration section).
4. Start the add-on.
5. Click the "OPEN WEB UI" button to access TeslaMate.

## Configuration

### Add-on Configuration Options

These options can be configured in the add-on configuration panel in Home Assistant:

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `TZ` | string | no | The timezone for TeslaMate. Defaults to your Home Assistant timezone. Example: "Europe/Berlin" |
| `APP_CONF_OVERRIDE` | string | no | Additional TeslaMate configuration overrides |

### Environment Variables

The add-on comes with several pre-configured environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | The port where TeslaMate web interface runs | 20211 |
| `PGID` | Process Group ID | 102 |
| `PUID` | Process User ID | 102 |
| `TZ` | Timezone setting | From add-on config |

## Network Ports

The add-on exposes the following ports:

| Port | Description |
|------|-------------|
| 20211 | TeslaMate Web UI port |
| 20212 | GraphQL API port |

## Features

- 🚗 Complete Tesla vehicle data logging
- 📊 Integrated Grafana dashboards for data visualization
- 🗄️ Built-in PostgreSQL database for data storage
- 🔌 MQTT integration for Home Assistant
- 🔒 Secure access through Home Assistant authentication
- 🌐 Ingress support for seamless Home Assistant integration

## Usage

1. **First-Time Setup**:
   - After starting the add-on, open the Web UI
   - Log in with your Tesla account credentials
   - Your vehicle(s) should appear in the dashboard

2. **Accessing Grafana** (if using bundled Grafana):
   - Navigate to the Grafana port or interface
   - Default credentials will be configured automatically
   - Browse the pre-configured Tesla dashboards

3. **MQTT Integration**:
   - The add-on automatically integrates with Home Assistant's MQTT broker if available
   - Tesla data will be published to MQTT topics for Home Assistant consumption

## Backup

The add-on stores its data in the following locations:

- PostgreSQL data: `/addon_config/teslamate/postgres`
- Grafana data: `/addon_config/teslamate/grafana`

These directories are automatically included in Home Assistant backups when the add-on is selected.

## Troubleshooting

1. **Database Connection Issues**:
   - Ensure the add-on has been stopped and restarted after initial configuration
   - Check the add-on logs for any PostgreSQL connection errors

2. **Tesla API Connection**:
   - Verify your Tesla account credentials
   - Check for any API rate limiting messages in the logs
   - Ensure your network connection is stable

3. **Grafana Dashboard Issues**:
   - Verify that Grafana is running (check add-on logs)
   - Ensure the database contains data (vehicle must have been connected)
   - Check for any database migration errors in the logs

## Support

- For add-on specific issues, please use the GitHub repository's issue tracker
- For TeslaMate general questions, refer to the [official TeslaMate documentation](https://docs.teslamate.org/)
- For Tesla API related issues, check the [Tesla Owner's API documentation](https://tesla-api.timdorr.com/)

## Security

This add-on requires the following privileges:
- Full Access: Required for complete vehicle data logging
- Host Network: Required for proper MQTT and web interface functionality
- Privileged: Required system permissions for full functionality

## Contributing

If you'd like to contribute to the add-on, please:
1. Fork the repository
2. Create a feature branch
3. Submit a Pull Request

## License

This add-on is published under the same license as TeslaMate.
