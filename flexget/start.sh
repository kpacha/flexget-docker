#!/bin/bash

sed -i "s@##RSS_URL##@$RSS_URL@" /root/.config/flexget/config.yml

/usr/local/bin/flexget "$@"