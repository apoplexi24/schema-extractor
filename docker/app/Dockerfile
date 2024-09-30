# Use Python base image
FROM python:3.11-slim

# Install system dependencies for PostgreSQL and Python build tools
RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    python3-dev
# Install ODBC dependencies
RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Microsoft ODBC Driver for SQL Server
RUN apt-get update && apt-get install -y curl gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# Set working directory
WORKDIR /app

# Copy the Poetry project files
COPY pyproject.toml poetry.lock ./

# Install dependencies (without installing the project itself)
RUN poetry install --no-root

# Copy the rest of the application code
COPY . .

# Run the app (or testing framework)
CMD ["poetry", "run", "pytest"]
