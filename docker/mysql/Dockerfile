FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=my-secret-pw
ENV MYSQL_DATABASE=my_database
ENV MYSQL_USER=my_user
ENV MYSQL_PASSWORD=my_password

EXPOSE 3306

COPY ./init.sql /docker-entrypoint-initdb.d/
