FROM imiobe/base:py2-ubuntu-20.04

ENV DEBIAN_FRONTEND noninteractive

LABEL name="Libreoffice Fresh" \
      description="A libreoffice server with custom font included for our customers" \
      maintainer="iMio"

COPY fonts/* /usr/local/share/fonts/
# needed because of jre installation bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199#23
RUN mkdir -p /usr/share/man/man1 \
  && add-apt-repository ppa:libreoffice/ppa \
  && apt-get update -qqy \
  && apt-get full-upgrade -qqy \
  && apt-get install -qqy -o APT::Install-Recommends=false \
    fontconfig \
    default-jre \
    libreoffice \
    libreoffice-script-provider-python \
    fonts-arkpandora-* \
    fonts-crosextra-* \
    fonts-dejavu \
    fonts-liberation \
    fonts-liberation2 \
    fonts-linuxlibertine \
    fonts-roboto* \
    fonts-sil-gentium-basic \
    poppler-data \
    poppler-utils \
    graphicsmagick \
    libmagic1 \
    libpng16-16 \
    libjpeg62 \
    libopenjp2-7 \
    libwebp6\
    lbzip2 \
    libsigc++-2.0-0v5 \
  && apt-get purge libreoffice-gnome libreoffice-gtk* libreoffice-help* libreoffice-kde* \
  && fc-cache -f

EXPOSE 2002

USER imio
WORKDIR /home/imio
# initilize ~/.config/libreoffice
RUN soffice --headless --terminate_after_init

CMD soffice --headless --norestore --accept="socket,host=libreoffice,port=2002,tcpNoDelay=1;urp;StarOffice.ServiceManager"