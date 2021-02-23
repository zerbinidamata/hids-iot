import db
import json
import argparse
import runner
import os
import threading

from watcher import LogsWatcher

# Insert rule in db and create CRON Task or execute rule based on peridocity
def create_rule_from_file(file):
    with open(file) as json_file:
        rule = json.load(json_file)
        rule_id = db.insert_rule(rule)
        if rule["periodicity"] == "0":
            runner.run_rule(rule)
        else:
            runner.create_cron_task(rule, rule_id)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--insert", help="Enter JSON path file to insert")
    args = parser.parse_args()
    create_rule_from_file(args.insert)
