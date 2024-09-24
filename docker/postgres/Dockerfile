FROM postgres:13

ENV POSTGRES_DB=my_database
ENV POSTGRES_USER=my_user
ENV POSTGRES_PASSWORD=my_password

EXPOSE 5432

COPY ./init.sql /docker-entrypoint-initdb.d/