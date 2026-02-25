#!/bin/bash

# install cloudflared
# Binary is copied from build stage
echo "$(date "+%d.%m.%Y %T") $(cloudflared -V) installed for ${ARCH}" >> /build_date.info


useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/
    
# install stubby
apk add --update --no-cache stubby \
    && echo "$(date "+%d.%m.%Y %T") $(stubby -V) installed for ${ARCH}" >> /build_date.info
    
# clean cloudflared config
mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml  
# add unbound version to build.info
echo "$(date "+%d.%m.%Y %T") Unbound $(/usr/local/sbin/unbound -V | head -1) installed for ${ARCH}" >> /build_date.info    

# add pihole version to build.info
echo "$(date "+%d.%m.%Y %T")  $(/usr/local/bin/pihole -v)"
echo "$(date "+%d.%m.%Y %T")  $(/usr/local/bin/pihole -v |sed -n '1p') installed" >> /build_date.info
echo "$(date "+%d.%m.%Y %T")  $(/usr/local/bin/pihole -v |sed -n '2p') installed" >> /build_date.info
echo "$(date "+%d.%m.%Y %T")  $(/usr/local/bin/pihole -v |sed -n '3p') installed" >> /build_date.info
# clean up
rm -rf /tmp/* /var/tmp/*