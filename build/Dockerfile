FROM ubuntu:23.10

RUN apt-get update \
    && apt-get install -y \
      wget \
      gnupg \
      openbox \
      xrdp \
      picom \
      tigervnc-standalone-server \
      novnc \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt install -y \
        google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

ADD openbox /etc/xdg/openbox
COPY entrypoint.sh /
COPY xrdp.ini /etc/xrdp

RUN adduser xrdp ssl-cert \
    && chmod -R 700 /entrypoint.sh \
    && chmod -R 755 /etc/xdg/openbox/autostart \
    && chmod -R 644 /etc/xdg/openbox/menu.xml \
    && chmod -R 644 /etc/xrdp/xrdp.ini

EXPOSE 3389 5900 5901

#Server Start
ENTRYPOINT ["/entrypoint.sh"]