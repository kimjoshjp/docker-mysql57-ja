FROM mysql:5.7


# ロケールを「ja_JP.UTF-8」に設定
RUN apt-get update && apt-get install -y locales
RUN sed -i -E 's/# (ja_JP.UTF-8 UTF-8)/\1/' /etc/locale.gen && locale-gen
RUN update-locale LANG=ja_JP.UTF-8

ENV LANG ja_JP.UTF-8

# タイムゾーンをAsia/Tokyoに設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# ベースディレクトリを環境変数に設定
ENV MYSQL_CONF_BASE_DIR /etc/mysql

# [mysqld]
# character-set-server=utf8
RUN echo 'character-set-server=utf8' >> ${MYSQL_CONF_BASE_DIR}/mysql.conf.d/mysqld.cnf

# [mysql]
# default-character-set=utf8
RUN echo 'default-character-set=utf8' >> ${MYSQL_CONF_BASE_DIR}/conf.d/mysql.cnf

# [mysqldump]
# default-character-set=utf8
RUN echo 'default-character-set=utf8' >> ${MYSQL_CONF_BASE_DIR}/conf.d/mysqldump.cnf

# [client]
# default-character-set=utf8
RUN touch ${MYSQL_CONF_BASE_DIR}/conf.d/mysqlclient.cnf
RUN echo '[client]' >> ${MYSQL_CONF_BASE_DIR}/conf.d/mysqlclient.cnf
RUN echo 'default-character-set=utf8' >> ${MYSQL_CONF_BASE_DIR}/conf.d/mysqlclient.cnf
