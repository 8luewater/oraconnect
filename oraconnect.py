import oracledb
import os
import logging
from dotenv import load_dotenv
import sql_string

load_dotenv()

oracledb.init_oracle_client()


# Database connection
db_conn_string = os.environ["db_conn_string"]
db_user = os.environ["db_user"]
db_password = os.environ["db_password"]

def database_select_table():
    sql_select = sql_string.sql_select
    conn, cur = database_conn()
    cur.execute(sql_select)
    select_table = cur.fetchall()
    table_count = cur.rowcount
    print("Table count: ",table_count)
    cur.close()
    conn.close()
    
    return None

def database_conn():
    try:
        conn = oracledb.connect(user=db_user, password=db_password, dsn=db_conn_string)
        cur = conn.cursor()
        print(f"Successfully connected to ORARDS")
    except oracledb.Error as e:
        print(f"database error: {e}")

    return conn, cur


def main():
    print(f"Hi GA: User {db_user} | Conn {db_conn_string} | Pwd {db_password}")
    #database_conn()
    database_select_table()

if __name__ == "__main__":
    main()