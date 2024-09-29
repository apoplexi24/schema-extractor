import pytest
import threading
from schema_extractor.postgres_schema_extractor import postgres_schema_extractor
from schema_extractor.mssql_schema_extractor import ms_sql_schema_extractor
from schema_extractor.mysql_schema_extractor import mysql_schema_extractor

# Lock for thread safety when asserting
lock = threading.Lock()

# Test MySQL connection
def test_mysql_connection():
    extractor = mysql_schema_extractor(
        host="mysql",
        dbname="my_database",
        user="my_user",
        password="my_password",
        port=3306
    )
    connection, cursor = extractor.connect_to_mysql()
    try:
        cursor.execute("SELECT DATABASE()")
        result = cursor.fetchone()
        with lock:
            assert result[0] == "my_database", "MySQL connection failed"
    finally:
        extractor.close_connection()

# Test PostgreSQL connection
def test_postgres_connection():
    extractor = postgres_schema_extractor(
        host="postgres",
        dbname="my_database",
        user="my_user",
        password="my_password",
        port=5432
    )
    connection, cursor = extractor.connect_to_postgres()
    try:
        cursor.execute("SELECT current_database()")
        result = cursor.fetchone()
        with lock:
            assert result[0] == "my_database", "PostgreSQL connection failed"
    finally:
        extractor.close_connection()

# Test MSSQL connection
def test_mssql_connection():
    extractor = ms_sql_schema_extractor(
        server="mssql,1433",
        database="my_database",
        username="sa",
        password="YourStrong@Passw0rd"
    )
    extractor.connect_to_mssql()
    try:
        cursor = extractor.mssql_cursor
        cursor.execute("SELECT DB_NAME()")
        result = cursor.fetchone()
        with lock:
            assert result[0] == "my_database", "MSSQL connection failed"
    finally:
        extractor.close_connection()

# Run the tests concurrently using pytest fixture
@pytest.mark.parametrize("test_func", [
    test_mysql_connection,
    test_postgres_connection,
    test_mssql_connection
])
def test_db_connections(test_func):
    thread = threading.Thread(target=test_func)
    thread.start()
    thread.join()

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
