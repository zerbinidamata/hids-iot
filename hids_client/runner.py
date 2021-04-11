import subprocess
from crontab import CronTab
import os
import yaml
import db

cwd = os.getcwd()


def get_rule_cmd(rule):
    test_case_scripts_path = f"{cwd}/scripts/test_cases"
    actions_scripts_path = f"{cwd}/scripts/actions"
    test_case = f" && bash {test_case_scripts_path}/".join(rule["test_case"]["scripts"])
    action = f" && bash {actions_scripts_path}/".join(rule["action"]["scripts"])

    cmd = f"bash  {test_case_scripts_path}/{test_case} && bash {actions_scripts_path}/{action} "
    return cmd


def check_policy(rule):
    with open("policy.yaml") as f:
        policy = yaml.safe_load(f)
        print(policy)
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
        cmd = get_rule_cmd(rule)
        os.system(cmd)
        print(cmd)
    else:
        # TODO: criar handler de orquestração da regra
        print("Acionar orquestrador")