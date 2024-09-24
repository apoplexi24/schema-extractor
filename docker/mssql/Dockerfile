FROM mcr.microsoft.com/mssql/server:2019-latest

ENV SA_PASSWORD=YourStrong@Passw0rd
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express
ENV MSSQL_DATABASE=my_database

EXPOSE 1433

COPY ./init.sql /docker-entrypoint-initdb.d/
