import psycopg2
import pandas as pd
import os
from typing import Optional, Tuple
from psycopg2.extensions import connection, cursor

class postgres_schema_extractor():
    def __init__(self, host: str, dbname: str, user: str, password: str, port: int = 5432) -> None:
        self.postgres_host = host
        self.postgres_dbname = dbname
        self.postgres_user = user
        self.postgres_password = password
        self.port = port
        self.postgres_connection: Optional[connection] = None
        self.postgres_cursor: Optional[cursor] = None

    def connect_to_postgres(self) -> Tuple[Optional[connection], Optional[cursor]]:
        try:
            # Establish the connection
            self.postgres_connection = psycopg2.connect(
                host=self.postgres_host,
                dbname=self.postgres_dbname,
                user=self.postgres_user,
                password=self.postgres_password,
                port=self.port
            )
            self.postgres_cursor = self.postgres_connection.cursor()

            # Test the connection
            self.postgres_cursor.execute("SELECT version();")
            db_version = self.postgres_cursor.fetchone()
            print(f"Connected to PostgreSQL database: {db_version}")

            return self.postgres_connection, self.postgres_cursor
        except Exception as error:
            print(f"Error while connecting to PostgreSQL: {error}")
            return None, None
        
    def close_connection(self) -> None:
        if self.postgres_cursor:
            self.postgres_cursor.close()
        if self.postgres_connection:
            self.postgres_connection.close()
            print("PostgreSQL connection closed.")
    
    def check_table_schema(self, table_name: str) -> None:  
        query = f"""SELECT column_name, data_type, character_maximum_length, is_nullable
        FROM information_schema.columns
        WHERE "table_name" = '{table_name}' """
        df = pd.read_sql_query(query, self.postgres_connection)
        os.makedirs(f'./schemas/{self.postgres_dbname}', exist_ok=True)
        df.to_json(f'./schemas/{self.postgres_dbname}/{table_name}.json', orient='records')
    

    def extract_schemas(self, table_name_list: list) -> None:
        self.connect_to_postgres()  
        for table_name in table_name_list:
            self.check_table_schema(table_name)
        self.close_connection()


