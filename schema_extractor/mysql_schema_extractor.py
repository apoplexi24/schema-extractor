import mysql.connector
from typing import Optional, Tuple
from mysql.connector import MySQLConnection
from mysql.connector.cursor import MySQLCursor
import pandas as pd
import os

class mysql_schema_extractor():
    def __init__(self, host: str, dbname: str, user: str, password: str, port: int = 3306):
        self.mysql_host = host
        self.mysql_dbname = dbname
        self.mysql_user = user
        self.mysql_password = password
        self.port = port
    
    def connect_to_mysql(self) -> Tuple[Optional[MySQLConnection], Optional[MySQLCursor]]:
        try:
            # Establish the connection
            self.mysql_connection = mysql.connector.connect(
                host=self.mysql_host,
                dbname=self.mysql_dbname,
                user=self.mysql_user,
                password=self.mysql_password,
                port=self.port
            )
            self.mysql_cursor = self.mysql_connection.cursor()
            return self.mysql_connection, self.mysql_cursor
        except mysql.connector.Error as e:
            print(f"Error connecting to MySQL: {e}")
            return None, None

    def close_connection(self) -> None:
        if self.mysql_cursor:
            self.mysql_cursor.close()
        if self.mysql_connection:
            self.mysql_connection.close()
            print("MySQL connection closed.")

    def check_table_schema(self, table_name: str, base_path: str = './schemas') -> None:
        query = f"""
        SELECT column_name, data_type, character_maximum_length, is_nullable
        FROM information_schema.columns
        WHERE table_name = '{table_name}' AND table_schema = '{self.mysql_dbname}';
        """
        df = pd.read_sql(query, self.mysql_connection)
        if base_path == './schemas/{self.mysql_dbname}/{table_name}.json':
            os.makedirs(f'./schemas/{self.mysql_dbname}', exist_ok=True)
        df.to_json(base_path, orient='records')

    def extract_multiple_schemas(self, table_name_list: list, base_path: str = './schemas') -> None:
        self.connect_to_mysql()
        for table_name in table_name_list:
            self.check_table_schema(table_name, base_path=base_path)
        self.close_connection()

    def extract_all_schemas(self, base_path: str = './schemas') -> None:
        self.connect_to_mysql()
        self.extract_multiple_schemas(self.get_all_table_names(), base_path=base_path)
        self.close_connection()

    def get_all_table_names(self) -> list:
        query = "SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema = 'dbo'"
        df = pd.read_sql(query, self.mysql_connection)
        return df['table_name'].tolist()    


