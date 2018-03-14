FROM jlw/base2

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install libc6-i686:i386 libexpat1:i386 libffi6:i386 \
                    libfontconfig1:i386 libfreetype6:i386 libgcc1:i386 \
                    libglib2.0-0:i386 libice6:i386 libpcre3:i386 \
                    libpng16-16:i386 libsm6:i386 libstdc++6:i386 \
                    libuuid1:i386 libx11-6:i386 libxau6:i386 libxcb1:i386 \
                    libxdmcp6:i386 libxext6:i386 libxrender1:i386 \
                    zlib1g:i386 libx11-xcb1:i386 libdbus-1-3:i386 \
                    libxi6:i386 libsm6:i386 libcurl3:i386 \
                    libgtk2.0-0:i386 gtk2-engines-murrine:i386 \
                    gtk2-engines-pixbuf:i386 \
                    python2.7-dev:i386 python2.7:i386 python2.7-minimal:i386

# install the freeware ida 7.0
COPY dist/idafree70_linux.run /
RUN /idafree70_linux.run --mode unattended --prefix /home/user/idafree
RUN chown -R user ~user/idafree
COPY dist/idafree.desktop /usr/share/applications
RUN rm /idafree70_linux.run

COPY dist/ida-6.5 /ida6.5
RUN tar -C /home/user -xzpf /ida6.5/ida-6.5.tar.gz
RUN rm /ida6.5/ida-6.5.tar.gz \
       /ida6.5/idapronl_*.run \
       /ida6.5/ida_*.key \
       /ida6.5/install.key
RUN mv /ida6.5/ida.desktop /ida6.5/ida64.desktop /usr/share/applications
#flair65.zip
#idasdk65.zip
#tilib65.zip

RUN apt-get -y install twm
