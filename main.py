import csv
import psycopg2
from datetime import datetime, timedelta
from psycopg2.errors import lookup
from utils.utils import get_env
from utils.consts import *
from utils.log import log_func
import re


def get_previous_run_time(cursor):
    try:
        cursor.execute(f"SELECT execute_time FROM {LAST_ROW_TABLE};")
        buf = cursor.fetchall()
        previous_run_work_time = buf[0][0]
    except Exception as e:
        log_func.info(f"Cannot get data from {LAST_ROW_TABLE}: {e}")
        previous_run_work_time = None

    return timedelta(microseconds=previous_run_work_time)


def create_zno_insert_query(row, year):
    buf = [row[el].replace("'", "`").split(",")[0] for el in row]
    buf.append(year)
    insert_buf = f"insert into {TABLE_NAME} values" + str(tuple(buf))

    insert_query = re.sub(r"'null'", "null", insert_buf)
    return insert_query


def get_user_query(cursor):
    """Варіант 7: Порівняти найкращий бал з Математики у 2020 та 2019 роках серед тих комубуло зараховано тест"""
    user_query = f"""select max(res.mathBall100), res.TestYear from {TABLE_NAME} as res
    where res.mathTestStatus = 'Зараховано'
    group by res.TestYear
    """

    outputquery = f"COPY ({user_query}) TO STDOUT WITH CSV HEADER"

    with open("resultQuery.csv", "w") as f:
        cursor.copy_expert(outputquery, f)
    log_func.info("COPY TO CSV SUCCESSFUL")


def create_tables(conn, cursor):
    log_func.info("Creating table")

    with open("queries/CREATE_BUFFER_TABLE.sql") as create_file:
        row_table_create = create_file.read().format(table_name=LAST_ROW_TABLE)

    with open("queries/CREATE_TABLE.sql") as create_file:
        create_table_query = create_file.read().format(table_name=TABLE_NAME)

    try:
        cursor.execute(create_table_query)
    except Exception as e:
        log_func.error(f"Table {TABLE_NAME}, {e}")

    try:
        cursor.execute(row_table_create)
        cursor.execute(f"INSERT INTO {LAST_ROW_TABLE} VALUES (0, 0, 0)")
    except Exception as e:
        log_func.error(f"{e}")

    conn.commit()
    log_func.info("Tables created")


def insert_data(conn, cursor, csv_filename, year, last_row_number, start_time):
    previous_stack_time = start_time
    log_func.info(f"Inserting data from {csv_filename}")
    with open(csv_filename, encoding="cp1251") as csv_file:
        csv_reader = csv.DictReader(csv_file, delimiter=";")

        i = 0
        for row in csv_reader:
            i += 1

            if i <= last_row_number:
                continue

            insert_zno_query = create_zno_insert_query(row, year)
            try:
                cursor.execute(insert_zno_query)
            except Exception as e:
                log_func.error(f"Something went wrong details ->: {e}")
                conn.rollback()
                return 1

            if i % 50 == 0:
                now = datetime.now()
                try:
                    cursor.execute(
                        f"UPDATE {LAST_ROW_TABLE} SET row_num={i}, year_file={year}, "
                        "execute_time=execute_time+"
                        f"{(now - previous_stack_time).microseconds};"
                    )
                    conn.commit()
                    print(i)
                except Exception as e:
                    log_func.error(f"Connection with db is broken: {e}")
                    conn.rollback()
                    return 1
                previous_stack_time = now

        conn.commit()

    log_func.info(f"Inserting from {csv_filename} is finished")


def main():
    start_time = datetime.now()
    log_func.info(f"Start time {start_time}")
    conn = psycopg2.connect(
        dbname=get_env("db_name"),
        user=get_env("db_user"),
        password=get_env("db_password"),
        host=get_env("db_url"),
    )
    cursor = conn.cursor()
    create_tables(conn, cursor)

    try:
        cursor.execute(f"SELECT * FROM {LAST_ROW_TABLE};")
        buf = cursor.fetchall()
        file_year = buf[0][0]
        row_number = buf[0][1]
    except Exception as e:
        log_func.warning(f"Cannot get data from {LAST_ROW_TABLE}: {e}")
        file_year = YEARS[0]
        row_number = 0

    conn.commit()
    log_func.info(
        f"Starting inserting from {row_number} row from file for {file_year} year"
    )
    if file_year:
        index = YEARS.index(file_year)
        for year in YEARS[index:]:
            insert_data(
                conn, cursor, f"Odata{year}File.csv", year, row_number, start_time
            )
            row_number = 0
    else:
        for year in YEARS:
            insert_data(
                conn, cursor, f"Odata{year}File.csv", year, row_number, start_time
            )
            row_number = 0

    get_user_query(cursor)
    inserting_time = get_previous_run_time(cursor)
    end_time = datetime.now()
    log_func.info(f"End time {end_time}")
    log_func.info(f"Inserting executing time {inserting_time}")
    cursor.close()
    conn.close()
    log_func.info("Program is finished")


if __name__ == "__main__":
    main()