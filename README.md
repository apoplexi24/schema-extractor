# Schema Extractor

Schema Extractor is a tool designed to extract database schemas and transfer data between different database systems. It supports multiple database systems including MySQL, PostgreSQL, and MSSQL, and can export schemas to JSON format.

## Features

- Extract schemas from MySQL, PostgreSQL, and MSSQL databases.
- Export schemas to JSON files.
- Transfer data between PostgreSQL and Google BigQuery.
- Docker support for easy setup and deployment.

## Project Structure


schema-extractor/
├── docker/
│ ├── mssql/
│ │ ├── Dockerfile
│ │ └── init.sql
│ ├── mysql/
│ │ ├── Dockerfile
│ │ └── init.sql
│ └── postgres/
│ ├── Dockerfile
│ └── init.sql
├── schema_extractor/
│ ├── mysql_schema_extractor.py
│ ├── mssql_schema_extractor.py
│ └── postgres_schema_extractor.py
├── data_migrate/
│ ├── data_transfer_new.py
│ ├── get_postgres_table_schema.py
│ └── schema-extractor/
│ └── postgres_schema_extractor.py
├── pyproject.toml
└── README.md


## Getting Started

### Prerequisites

- Docker
- Python 3.11
- Poetry (for dependency management)

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/yourusername/schema-extractor.git
    cd schema-extractor
    ```

2. Install dependencies using Poetry:

    ```sh
    poetry install
    ```

### Usage

#### Docker Setup

1. Build and run the Docker containers for the databases:

    ```sh
    docker-compose up -d
    ```

2. The `init.sql` scripts in each database directory will initialize the databases with sample data.

#### Extracting Schemas

1. MySQL:

    ```python
    from schema_extractor.mysql_schema_extractor import mysql_schema_extractor

    extractor = mysql_schema_extractor(host='localhost', dbname='my_database', user='my_user', password='my_password')
    extractor.extract_all_schemas()
    ```

2. PostgreSQL:

    ```python
    from schema_extractor.postgres_schema_extractor import postgres_schema_extractor

    extractor = postgres_schema_extractor(host='localhost', dbname='my_database', user='my_user', password='my_password')
    extractor.extract_schemas(['table1', 'table2'])
    ```

3. MSSQL:

    ```python
    from schema_extractor.mssql_schema_extractor import MSSQLSchemaExtractor

    extractor = MSSQLSchemaExtractor(server='localhost', database='my_database', username='my_user', password='my_password')
    extractor.extract_all_schemas()
    ```

## Configuration

### Environment Variables

Create a `.env` file in the root directory and add the following variables:
DB_HOST=your_db_host
DB_USER=your_db_user
DB_PASSWORD=your_db_password


### Docker Configuration

Modify the `Dockerfile` and `init.sql` files in the `docker` directory to customize the database setup.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
