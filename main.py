import psycopg2

def add_employees(new_empl):
    conn = psycopg2.connect(
        dbname = "icecreamshop_db"
    )
    # print()

    cur = conn.cursor()

    # cur.execute("""""")

    insert_query = """INSERT INTO employees (empl_name, hours_id) VALUES (%s, %s)"""

    cur.execute(insert_query, new_empl)
    # print("inserted")

    conn.commit()

def main():
    print("===Admin===")
    print("""1. Add new employee
2. Add inventory
3. Add sales""")

    choices = input("Enter choice number: ")

    if choices == "1":
        add_name = input("Enter name: ")
        work_hr = int(input("Work Time: "))

        new_emp = (add_name, work_hr)

        add_employees(new_emp)
        print("Employee added!")

main()