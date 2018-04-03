FROM greyltc/lamp

COPY docker-startup.sh /
ADD setupMysqlUser.sh /usr/sbin/setup-mysql-user

ENV MYSQL_USER mitglieder
ENV MYSQL_PASSWORD mitglieder
ENV MYSQL_DATABASE mitglieder

CMD bash /docker-startup.sh
