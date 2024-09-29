# Use Python base image
FROM python:3.11-slim

# Install system dependencies for PostgreSQL and Python build tools
RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    python3-dev

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
