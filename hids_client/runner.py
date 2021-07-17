from crontab import CronTab
import os
import yaml
import reports_producer
import subprocess
import json
import sys


cwd = os.getcwd()
device_id = os.environ["DEVICE_ID"]


def execute_scripts(rule):
    test_case_scripts_path = f"{cwd}/scripts/test_cases"
    actions_scripts_path = f"{cwd}/scripts/actions"

    for test_case in rule["test_case"]["scripts"]:
        res = subprocess.run(
            f"bash {test_case_scripts_path}/{test_case}",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            shell=True,
        )
        reports_producer.generate_report(json.loads(res.stdout.decode("utf-8")))
        if res.returncode == 1:
            reports_producer.generate_report(
                {
                    "message": f"Device {device_id} raised error and exited running test_case {test_case} for"
                    + rule["name"]
                    + "with id"
                    + str(rule["id"]),
                    "type": "test_case",
                    "name": test_case,
                    "rule_id": rule["id"],
                    "status": "failed",
                }
            )
            sys.exit(0)
        reports_producer.generate_report(
            {
                "message": f"Device {device_id} sucessfully executed test_case {test_case} for"
                + rule["name"]
                + "with id"
                + str(rule["id"]),
                "type": "test_case",
                "name": test_case,
                "rule_id": rule["id"],
                "status": "success",
            }
        )

    for action in rule["action"]["scripts"]:
        res = subprocess.run(
            f"bash {actions_scripts_path}/{action}",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            shell=True,
        )
        reports_producer.generate_report(json.loads(res.stdout.decode("utf-8")))
        if res.returncode == 1:
            reports_producer.generate_report(
                {
                    "message": f"Device {device_id} raised error and exited running action {action} for"
                    + rule["name"]
                    + "with id"
                    + str(rule["id"]),
                    "type": "action",
                    "name": action,
                    "rule_id": rule["id"],
                }
            )
            sys.exit(0)
        reports_producer.generate_report(
            {
                "message": f"Device {device_id} sucessfully executed test_case {test_case} for"
                + rule["name"]
                + "with id"
                + str(rule["id"]),
                "type": "action",
                "name": action,
                "rule_id": rule["id"],
                "status": "success",
            }
        )


def check_policy(rule):
    with open("policy.yaml") as f:
        policy = yaml.safe_load(f)
        if set(rule["test_case"]["scripts"]).issubset(policy["scripts"]) and set(
            rule["action"]["scripts"]
        ).issubset(policy["scripts"]):
            return True


# Create cron task file and logs for test_cases
# The file pattern is {id}_test_case
def create_cron_task(rule):
    cron = CronTab(user="root")
    cmd = get_rule_cmd(rule)
    job = cron.new(command=cmd)
    job.setall(rule["periodicity"])
    cron.write()


# Execute rule
def execute_rule(rule):
    policy_compatible = check_policy(rule)
    if policy_compatible:
        reports_producer.generate_report(
            {"message": "Device started execution of rule" + rule["name"]}
        )
        execute_scripts(rule)
    else:
        # TODO: criar handler de orquestração da regra
        print("Acionar orquestrador")