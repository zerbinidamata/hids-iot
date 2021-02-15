import db
import json
import argparse


def create_rule_from_file(file):
    with open(file) as json_file:
        rule = json.load(json_file)
        db.insert_rule(rule)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--insert", help="Enter JSON path file to insert")
    args = parser.parse_args()
    create_rule_from_file(args.insert)
