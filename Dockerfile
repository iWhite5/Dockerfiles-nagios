FROM iwhite5/nubuntu-base
LABEL Isaac A. White <iwhite@nagios.com>

RUN sudo make install-groups-users
RUN sudo usermod -a -G nagios www-data

RUN sudo make install
RUN sudo make install-daemoninit
RUN sudo make install-commandmode
RUN sudo make install-config
RUN sudo make install-webconf
RUN sudo a2enmod rewrite
RUN sudo a2enmod cgi
#RUN sudo ufw allow Apache
#RUN sudo ufw reload
RUN sudo htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin admin

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart

# Open up valid ports to listen to outside of the container
EXPOSE 80 443 3306 3307 8000 8001 8002

RUN apache2ctl start