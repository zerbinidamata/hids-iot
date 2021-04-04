import sqlite3
from datetime import datetime

database_file = "rules.db"


def connect():
    conn = sqlite3.connect(database_file)
    create_tables(conn)
    conn.close()


def create_tables(conn):
    c = conn.cursor()
    c.execute(
        """
    CREATE TABLE IF NOT EXISTS rules (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            created_at DATE NOT NULL,
            test_case_periodicity TEXT NOT NULL,
            action_periodicity TEXT NOT NULL,
            cpu_consumption INTEGER NOT NULL
    );
    """
    )
    c.execute(
        """
    CREATE TABLE IF NOT EXISTS test_cases (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            script TEXT NOT NULL
    );
    """
    )
    c.execute(
        """
    CREATE TABLE IF NOT EXISTS actions (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            script TEXT NOT NULL
    );
    """
    )
    c.execute(
        """
    CREATE TABLE IF NOT EXISTS rules_test_cases (
            rule_id INTEGER,
            test_case_id INTEGER
    );
    """
    )
    c.execute(
        """
    CREATE TABLE IF NOT EXISTS rules_actions (
            rule_id INTEGER,
            action_id   INTEGER
    );
    """
    )
    conn.close()


# TODO: update relationships
def get_rule_by_attr(attr_name, attr_value):
    query = """
    SELECT * FROM rules
    WHERE {0} = '{1}';
    """.format(
        attr_name, attr_value
    )
    cursor.execute(query)
    rule = cursor.fetchall()
    conn.close()
    if len(rule) == 0:
        return False
    return rule[0]


def insert_rule(rule):
    conn = sqlite3.connect(database_file)
    cursor = conn.cursor()
    # Create rule ref
    cursor.execute(
        """
        INSERT INTO rules (name, created_at, test_case_periodicity, action_periodicity,cpu_consumption)
        VALUES (?,?,?,?,?)
        """,
        (
            rule["name"],
            datetime.now(),
            rule["test_case"]["periodicity"],
            rule["action"]["periodicity"],
            0,
        ),
    )
    conn.commit()
    rule_id = cursor.lastrowid
    # Create test_cases and rules test_case ref
    for script in rule["test_case"]:
        cursor.execute(
            """
        INSERT INTO test_cases (script)
        VALUES (?)
        """,
            (script,),
        )
        conn.commit()
        test_case_id = cursor.lastrowid
        cursor.execute(
            """
        INSERT INTO rules_test_cases (rule_id, test_case_id)
        VALUES(?,?)
        """,
            (rule_id, test_case_id),
        )
        conn.commit()

    # Create actions and rules action ref
    for script in rule["action"]:
        cursor.execute(
            """
            INSERT INTO actions (script)
            VALUES(?)
        """,
            (script,),
        )
        test_case_id = cursor.lastrowid
        cursor.execute(
            """
            INSERT INTO rules_actions (rule_id, action_id)
            VALUES(?,?)
        """,
            (rule_id, test_case_id),
        )

    conn.commit()
    conn.close()
    return cursor.lastrowid


# TODO: update relationships
def update_rule(selector, rule):
    s_name = selector.keys()[0]
    s_value = str(selector.values()[0])
    if s_name == "name":
        cursor.execute(
            """
        UPDATE rules 
        SET name = ?, test_case = ?, premise = ?, action = ?, created_at = ?
        WHERE name = ?
        """,
            (
                rule["name"],
                rule["test_case"],
                rule["premise"],
                rule["action"],
                rule["created_at"],
                s_value,
            ),
        )
    elif s_name == "id":
        cursor.execute(
            """
        UPDATE rules 
        SET name = ?, test_case = ?, premise = ?, action = ?, created_at = ?
        WHERE id = ?
        """,
            (
                rule["name"],
                rule["test_case"],
                rule["premise"],
                rule["action"],
                rule["created_at"],
                s_value,
            ),
        )
    conn.commit()
    conn.close()


# TODO: update relationships
def get_rules():
    cursor.execute(
        """
    SELECT * FROM rules;
    """
    )
    rules = []
    for line in cursor.fetchall():
        rules.append(line)
    conn.close()
    return rules


# TODO: update relationships
def is_existing_rule(rule):
    id_rule = rule["id"]
    cursor.execute(
        """
    SELECT * FROM rules 
    WHERE id = ?
    """,
        (id_rule),
    )

    if len(cursor.fetchall()) != 0:
        return True
    return False


connect()