#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sqlite3
from datetime import datetime

database_file = "rules.db"


def connect():
    conn = sqlite3.connect(database_file)
    create_rules_table(conn)
    conn.close()


def create_rules_table(conn):
    cursor = conn.cursor()
    cursor.execute(
        """
    CREATE TABLE IF NOT EXISTS rules (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            test_case TEXT NOT NULL,
            premise TEXT NOT NULL,
            action TEXT NOT NULL,
            created_at DATE NOT NULL,
            engine TEXT NOT NULL,
            periodicity INTEGER NOT NULL,
            cpu_consumption INTEGER NOT NULL
    );
    """
    )
    conn.close()


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
    cursor.execute(
        """
    INSERT INTO rules (name, test_case, premise, action, created_at, engine, periodicity, cpu_consumption)
    VALUES (?,?,?,?,?,?,?,?)
    """,
        (
            rule["name"],
            rule["test_case"],
            rule["premise"],
            rule["action"],
            datetime.now(),
            rule["engine"],
            rule["periodicity"],
            rule["cpu_consumption"],
        ),
    )
    conn.commit()
    conn.close()


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