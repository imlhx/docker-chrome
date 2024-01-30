#!/bin/bash

rdpuser=${RDP_USER:-"rdp"}
rdppass=${RDP_PASS:-"rdp"}

vncuser=${VNC_USER:-"vnc"}
vncpass=${VNC_PASS:-"12345678"}

width=${VNC_DISPLAY_WIDTH:-"1920"}
height=${VNC_DISPLAY_HEIGHT:-"1080"}

for user in "$vncuser" "$rdpuser"; do
  if getent passwd "$user" &>/dev/null; then
    echo "User $user exists."
  else
    echo "User $user does not exist."
    useradd -m $user
  fi
done

echo "$rdpuser:$rdppass" | chpasswd

rm -rf /var/run/xrdp/xrdp.pid
rm -rf /var/run/xrdp/xrdp-sesman.pid

xrdp
xrdp-sesman

rm -rf /tmp/.X0-lock
rm -rf /tmp/.X11-unix/X0

su -c "mkdir -p ~/.vnc \
       && echo -e '${vncpass}\n${vncpass}' | vncpasswd -f >~/.vnc/passwd \
       && chmod 600 ~/.vnc/passwd \
       && vncserver :0 -useold -geometry ${width}x${height} -depth 32 -localhost no" -s /bin/bash $vncuser

/usr/share/novnc/utils/novnc_proxy --listen 5901
