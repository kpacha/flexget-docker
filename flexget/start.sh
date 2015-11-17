#!/bin/bash

sed "s@__RSS_URL__@$RSS_URL@" </root/flexget/config_base.yml >/root/.flexget/config.yml
sed -i "s@__SUBTITLES_LANGUAGE__@$SUBTITLES_LANGUAGE@" /root/.flexget/config.yml

/usr/local/bin/flexget "$@"