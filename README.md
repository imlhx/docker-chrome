# RDP/VNC/noVNC Google Chrome

# Usage

## Quick Run:

    docker run -itd --rm --privileged -p 3389:3389 -p 5900:5900 -p 5901:5901 imlhx/chrome:latest

## Connect:

RDP Client
    
    Computer: ip:3389
    Username: rdp
    Password: rdp

VNC Client
    
      Server: ip:5900
    Password: 12345678

noVNC Web
    
     Web URL: ip:5901/vnc.html
    Password: 12345678

# Environment Variables

* **RDP_USER:**
  User for Remote Desktop RDP connections. default: rdp


* **RDP_PASS:**
  It is the password to log in via RDP_USER. default: rdp


* **VNC_USER:** 
  User for Remote Desktop VNC connections. default: vnc


* **VNC_PASS:** 
  This is the connection password for VNC. default: 12345678


* **VNC_DISPLAY_WIDTH:** 
  It specifies the screen width in pixels for VNC. default: 1920


* **VNC_DISPLAY_HEIGHT:** 
  It specifies the screen height in pixels for VNC. default: 1080

# Docker Compose

    version: "3.9"
    services:
      chrome:
        image: imlhx/chrome:latest
        container_name: chrome
        hostname: chrome
        privileged: true
        restart: always
        ports:
          - "3389:3389"
          - "5900:5900"
          - "5901:5901"
        environment:
          LANG: "C.utf8"
          RDP_USER: "rdp"
          RDP_PASS: "rdp"
          VNC_USER: "vnc"
          VNC_PASS: "12345678"
        volumes:
          - /etc/localtime:/etc/localtime
        healthcheck:
          test: [ "CMD-SHELL", "lsof -i :3389 -i :5900 -i :5901 >/dev/null 2>&1 || reboot" ]
          interval: 5s
          timeout: 3s
          retries: 3
          start_period: 30s

# Reference

[Running Chrome in a Docker container](https://medium.com/dot-debug/running-chrome-in-a-docker-container-a55e7f4da4a8)  
[Does anyone know what causes black borders to appear in many gtk application drop-down menu?](https://www.reddit.com/r/i3wm/comments/11jw9el/does_anyone_know_what_causes_black_borders_to/?rdt=57956)  