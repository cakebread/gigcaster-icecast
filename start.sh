#!/bin/sh

CONFIG_FILE="/home/icecast/config/icecast.xml"
SUPERVISOR_CONFIG_FILE="/home/icecast/config/supervisord.conf"

env

set -x

if [ -n "$ICECAST_LOCATION" ]; then
    sed -i "s/<location>[^<]*<\/location>/<location>$ICECAST_LOCATION<\/location>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_ADMIN_EMAIL" ]; then
    sed -i "s/<admin>[^<]*<\/admin>/<admin>$ICECAST_ADMIN_EMAIL<\/admin>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_MAX_LISTENERS" ]; then
    sed -i "s/<clients>[^<]*<\/clients>/<clients>$ICECAST_MAX_LISTENERS<\/clients>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_MAX_SOURCES" ]; then
    sed -i "s/<sources>[^<]*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
    sed -i "s/<source-password>[^<]*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
    sed -i "s/<relay-password>[^<]*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
    sed -i "s/<admin-password>[^<]*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_HOSTNAME" ]; then
    sed -i "s/<hostname>[^<]*<\/hostname>/<hostname>$ICECAST_HOSTNAME<\/hostname>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_MOUNT_PASSWORD" ]; then
    sed -i "s/<password>[^<]*<\/password>/<password>$ICECAST_MOUNT_PASSWORD<\/password>/g" $CONFIG_FILE
fi

if [ -n "$ICECAST_RELAY_SERVER" ]; then
    sed -i "s/<server>[^<]*<\/server>/<server>$ICECAST_RELAY_SERVER<\/server>/g" $CONFIG_FILE
fi


if [ -n "$SUPERVISOR_ADMIN_USER" ]; then
    sed -i "s/username=admin/username=$SUPERVISOR_ADMIN_USER/g" $SUPERVISOR_CONFIG_FILE
fi

if [ -n "$SUPERVISOR_ADMIN_PASSWORD" ]; then
    sed -i "s/password=admin123/password=$SUPERVISOR_ADMIN_PASSWORD/g" $SUPERVISOR_CONFIG_FILE
fi

supervisord -c $SUPERVISOR_CONFIG_FILE
supervisorctl reread
supervisorctl update

