FROM imiobe/base:debian-buster

ENV DEBIAN_FRONTEND noninteractive

LABEL plone=$PLONE_VERSION \
    name="Libreoffice 6.1" \
    description="A libreoffice server with custom font included for our customers" \
    maintainer="iMio"

COPY fonts/* /usr/local/share/fonts/
# needed because of jre installation bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199#23
RUN mkdir -p /usr/share/man/man1 \
  && apt-get update -qqy \
  && apt-get full-upgrade -qqy \
  && apt-get install -qqy -o APT::Install-Recommends=false \
    fontconfig \
    poppler-data \
    poppler-utils \
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
  && fc-cache -f

EXPOSE 2002
USER imio
WORKDIR /home/imio
ENTRYPOINT ["/usr/bin/soffice"]
CMD ["--headless", "--norestore", "--nofirststartwizard", "--nodefault", "--accept='socket,host=libreoffice,port=2002,tcpNoDelay=1;urp;StarOffice.ServiceManager'"]