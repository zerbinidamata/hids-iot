import db
import yaml
import argparse
import runner
import os
import threading


# Insert rule in db and create CRON Task or execute rule based on peridocity
def create_rule_from_file(file):
    with open(file) as f:
        rule = yaml.safe_load(f)
        # TODO: redis vs sqlite(necessity of having DB in hids_client)
        rule_id = db.insert_rule(rule)
        if rule["periodicity"] == 0:
            runner.execute_rule(rule)
        else:
            runner.create_cron_task(rule)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--insert", help="Enter YAML path file to insert")
    args = parser.parse_args()
    create_rule_from_file(args.insert)
