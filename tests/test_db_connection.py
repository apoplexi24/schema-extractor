import threading
from schema_extractor.postgres_schema_extractor import postgres_schema_extractor
from schema_extractor.mssql_schema_extractor import ms_sql_schema_extractor
from schema_extractor.mysql_schema_extractor import mysql_schema_extractor

# Lock for thread safety when printing
print_lock = threading.Lock()

# Test MySQL connection
def test_mysql_connection():
    try:
        extractor = mysql_schema_extractor(
            host="mysql",
            dbname="my_database",
            user="my_user",
            password="my_password",
            port=3306
        )
        connection, cursor = extractor.connect_to_mysql()
        if connection and cursor:
            with print_lock:
                print("MySQL connection successful")
            extractor.close_connection()
        else:
            with print_lock:
                print("MySQL connection failed")
    except Exception as e:
        with print_lock:
            print(f"MySQL connection failed: {e}")

# Test PostgreSQL connection
def test_postgres_connection():
    try:
        extractor = postgres_schema_extractor(
            host="postgres",
            dbname="my_database",
            user="my_user",
            password="my_password",
            port=5432
        )
        connection, cursor = extractor.connect_to_postgres()
        if connection and cursor:
            with print_lock:
                print("PostgreSQL connection successful")
            extractor.close_connection()
        else:
            with print_lock:
                print("PostgreSQL connection failed")
    except Exception as e:
        with print_lock:
            print(f"PostgreSQL connection failed: {e}")

# Test MSSQL connection
def test_mssql_connection():
    try:
        extractor = ms_sql_schema_extractor(
            server="mssql,1433",
            database="my_database",
            username="sa",
            password="YourStrong@Passw0rd"
        )
        extractor.connect_to_mssql()
        with print_lock:
            print("MSSQL connection successful")
        extractor.close_connection()
    except Exception as e:
        with print_lock:
            print(f"MSSQL connection failed: {e}")

# Run tests concurrently
def run_tests_concurrently():
    threads = []
    
    mysql_thread = threading.Thread(target=test_mysql_connection)
    postgres_thread = threading.Thread(target=test_postgres_connection)
    mssql_thread = threading.Thread(target=test_mssql_connection)
    
    threads.append(mysql_thread)
    threads.append(postgres_thread)
    threads.append(mssql_thread)
    
    # Start all threads
    for thread in threads:
        thread.start()

    # Wait for all threads to finish
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    run_tests_concurrently()
