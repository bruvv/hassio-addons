#!/usr/bin/with-contenv bashio

######################
# MOUNT LOCAL SHARES #
######################
MOUNTPOINTS="share"

bashio::log.info 'Mounting external hdd...'

# Mount local Share if configured and if Protection Mode is active
if bashio::config.has_value 'localdisks'; then

  MOREDISKS=$(bashio::config 'localdisks')
  bashio::log.info "Local Disks mounting..."

  # Separate comma separated values
  for disk in ${MOREDISKS//,/ }; do
    # Mount each disk
    mkdir -p /$MOUNTPOINTS/$disk
    chown -R $(id -u):$(id -g) /$MOUNTPOINTS/$disk
    mount /dev/$disk /$MOUNTPOINTS/$disk
    bashio::log.info "Success! $disk mounted to /$MOUNTPOINTS/$disk" ||
      # Error message and clean remaining folder
      (bashio::log.warning "Unable to mount local drives!" &&
        rmdir /$MOUNTPOINTS/$disk)
  done
fi
