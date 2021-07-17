import json
import argparse
import runner


# Insert rule in db and create CRON Task or execute rule based on peridocity
def create_rule_from_file(file):
    with open(file) as f:
        rule = json.load(f)
        if int(rule["periodicity"]) == 0:
            runner.execute_rule(rule)
        else:
            runner.create_cron_task(rule)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--insert", help="Enter JSON path file to insert")
    args = parser.parse_args()
    create_rule_from_file(args.insert)
