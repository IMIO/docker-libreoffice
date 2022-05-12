FROM imiobe/base:py2-ubuntu-22.04

ENV DEBIAN_FRONTEND noninteractive
# ARG LO_PPA=libreoffice-still

LABEL name="Libreoffice" \
      description="A libreoffice server with custom font included for our customers" \
      maintainer="iMio"

COPY fonts/* /usr/local/share/fonts/

# RUN add-apt-repository -yu ppa:libreoffice/$LO_PPA \
RUN apt-get update -qqy \
  && apt-get full-upgrade -qqy \
  && apt-get install --no-install-recommends -qqy \
    python-is-python3 \
    fontconfig \
    openjdk-18-jre-headless \
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
    libwebp7 \
    libopenjp2-7 \
    libtiff5 \
    libgif7 \
    librsvg2-bin \
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
