FROM imiobe/base:py2-ubuntu-22.04

ENV DEBIAN_FRONTEND noninteractive
#ARG LO_PPA=libreoffice-fresh
ARG LO_PPA=ppa

LABEL name="Libreoffice" \
      description="A libreoffice server with custom font included for our customers" \
      maintainer="iMio"

COPY fonts/* /usr/local/share/fonts/

RUN add-apt-repository -y ppa:libreoffice/${LO_PPA} \
  && apt-get update -qqy \
  && apt-get full-upgrade -qqy \
  && apt-get install --no-install-recommends -qqy \
    python-is-python3 \
    fontconfig \
    default-jre-headless \
    libreoffice-java-common \
    libreoffice \
    fonts-arkpandora* \
    fonts-croscore* \
    fonts-crosextra* \
    fonts-dejavu \
    fonts-liberation \
    fonts-liberation2 \
    fonts-linuxlibertine \
    fonts-roboto* \
    fonts-noto* \
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
  && apt-get purge libreoffice-gnome* libreoffice-gtk* libreoffice-help* libreoffice-kde* \
  && fc-cache -f

EXPOSE 2002

USER imio
WORKDIR /home/imio
COPY --chown=imio apply_binding.py font-mappings.csv /home/imio/
HEALTHCHECK --timeout=1s CMD timeout 1s bash -c ':> /dev/tcp/127.0.0.1/2002'
# initilize ~/.config/libreoffice
RUN soffice --headless --terminate_after_init  \
# configure font replacement
  && python3 apply_binding.py \
  && rm apply_binding.py font-mappings.csv

CMD soffice '--accept=socket,host=0.0.0.0,port=2002;urp;StarOffice.ServiceManager' --nologo --headless --nofirststartwizard --norestore

