FROM debian

# We need xrdp and xorgxrdp from stretch-backports because Docker on
# windows doesn't private IPv6 sockets and xrdp from stretch doesn't
# cope well.
#
# Also, this is fetching of lxde-core... seems wasteful. Prune.
#
RUN echo deb http://deb.debian.org/debian stretch-backports main >> /etc/apt/sources.list
RUN	apt-get update
RUN apt-get -y install lxde-core lxterminal iceweasel vim-tiny
RUN apt -y install -t stretch-backports xrdp xorgxrdp
RUN apt-get -y install xterm openbox
RUN apt-get clean
RUN apt-get -y remove

RUN useradd -ms /bin/bash user
RUN	echo 'user:password' | chpasswd

RUN sed -i -e 's/^TerminalServerUsers=/;\0/' \
           -e 's/^TerminalServerAdmins=/;\0/' /etc/xrdp/sesman.ini
RUN sed -i -e 's/^username=.*/username=user/' \
           -e 's/^password=.*/password=password/' /etc/xrdp/xrdp.ini
# TODO: comment out the extra session types from xrdb.ini

RUN sed -i -e 's/^allowed_users=/#\0/' /etc/X11/Xwrapper.config
RUN echo allowed_users=anybody >> /etc/X11/Xwrapper.config

# Start openbox and xterm
RUN echo '#!/bin/sh' > /home/user/.xsession
RUN echo 'xterm -ls &' >> /home/user/.xsession
RUN echo 'exec /usr/bin/openbox' >> /home/user/.xsession
RUN chmod 755 /home/user/.xsession
RUN chown user /home/user/.xsession

RUN rm /etc/xrdp/key.pem
RUN cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/xrdp/key.pem

EXPOSE 3389

CMD ["/etc/init.d/xrdp", "start", "&&", "tail", "-f", "/var/log/xrdp-sesman.log"]
