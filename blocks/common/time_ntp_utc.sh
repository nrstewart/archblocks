#/!bin/bash
#
# TIME

ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo ${TIMEZONE} >> /etc/timezone
hwclock --systohc --utc # set hardware clock
_installpkg ntp

if _systemd; then
    systemctl enable ntpd.service
else
    sed -i "/^DAEMONS/ s/hwclock /!hwclock @ntpd /" /etc/rc.conf
fi

