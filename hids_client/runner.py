import subprocess
from crontab import CronTab
import os
import db
import report

# Create cron task file and logs for test_cases
# The file pattern is {id}_test_case
def create_cron_task(rule, id):
    cron = CronTab(user="root")
    f = open(f"./cron_rules/{id}_test_case.py", "w")
    f.write(rule["test_case"])
    f.close()
    cwd = os.getcwd()
    job = cron.new(
        command=f"python {cwd}/cron_rules/{id}_test_case.py >> {cwd}/cron_rules/logs/{id}_test_case.log"
    )
    job.setall(rule["periodicity"])
    cron.write()


# Creates files and execute 1-time-rules
def check_test_case(rule, rule_id):
    f = open("tmp.py", "w")
    f.write(rule["test_case"])
    f.close()
    cmd = ["python", "tmp.py"]
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
    if rule["premise"] in output.decode("utf-8"):
        report.generate_report(f"Rule {rule_id} action executed")
        run_rule(rule)


# Check the ouput of CRON rules when log event is fired
def check_cron_output(filePath):
    # Retrieves db rule
    rule_id = filePath.split("_")[0]
    rule = db.get_rule_by_attr("id", rule_id)
    # Check if log output matches rule output
    line = subprocess.check_output(["tail", "-1", filePath])
    if line == rule["output"]:
        report.generate_report(f"Rule {rule_id} action executed")
        run_rule(rule)


# Execute rule actions
def run_rule(rule):
    f = open("tmp.py", "w")
    f.write(rule["action"])
    f.close()
    cmd = ["python", "tmp.py"]
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
    print(output)