import os
import pandas as pd
import pyodbc

class MSSQLSchemaExtractor():
    def __init__(self, server, database, username, password):
        self.mssql_server = server
        self.mssql_database = database
        self.mssql_username = username
        self.mssql_password = password
        self.mssql_connection = None
        self.mssql_cursor = None

    def connect_to_mssql(self):
        connection_string = (
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=' + self.mssql_server + ';'
            'DATABASE=' + self.mssql_database + ';'
            'UID=' + self.mssql_username + ';'
            'PWD=' + self.mssql_password
        )
        try:
            self.mssql_connection = pyodbc.connect(connection_string)
            self.mssql_cursor = self.mssql_connection.cursor()
        except pyodbc.Error as e:
            print(f"Error connecting to MSSQL: {e}")
            raise e

    def close_connection(self):
        if self.mssql_cursor:
            self.mssql_cursor.close()
        if self.mssql_connection:
            self.mssql_connection.close()
            print("MSSQL connection closed.")

    def check_table_schema(self, table_name: str, schema_name: str = 'dbo', json_path: str = './schemas/{self.mssql_database}/{table_name}.json') -> None:
        query = f"""
        SELECT column_name, data_type, character_maximum_length, is_nullable
        FROM information_schema.columns
        WHERE table_name = '{table_name}' AND table_schema = '{schema_name}'
        """
        df = pd.read_sql(query, self.mssql_connection)
        if json_path == './schemas/{self.mssql_database}/{table_name}.json':
            os.makedirs(f'./schemas/{self.mssql_database}', exist_ok=True)
        df.to_json(json_path, orient='records')

    def extract_multiple_schemas(self, table_name_list: list, base_path: str = './schemas') -> None:
        self.connect_to_mssql()
        for table_name in table_name_list:
            json_path = f'{base_path}/{self.mssql_database}/{table_name}.json'
            self.check_table_schema(table_name, json_path=json_path)
        self.close_connection()
    
    def extract_single_schema(self, table_name: str, json_path: str = None) -> None:
        self.connect_to_mssql()
        self.check_table_schema(table_name, json_path=json_path)
        self.close_connection()

    def extract_all_schemas(self, base_path: str = './schemas') -> None:
        self.connect_to_mssql()
        self.extract_multiple_schemas(self.get_all_table_names(), base_path=base_path)
        self.close_connection()

    def get_all_table_names(self) -> list:
        query = "SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema = 'dbo'"
        df = pd.read_sql(query, self.mssql_connection)
        return df['table_name'].tolist()
        
