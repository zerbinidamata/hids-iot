import subprocess
from crontab import CronTab
import os

# Create cron task file and logs for test_cases
# The file pattern is {id}_test_case
def create_cron_task(rule, id):
    cron = CronTab(user="root")
    f = open(f"./cron_rules/{id}_test_case.py", "w")
    f.write(rule["test_case"])
    f.close()
    cwd = os.getcwd()
    job = cron.new(
        command=f"python {cwd}/cron_rules/{id}_test_case.py 2> ./cron_rules/logs/{id}_test_case.log"
    )
    job.setall(rule["periodicity"])
    cron.write()


# Creates files and execute 1-time-rules
def run_rule(rule):
    f = open("tmp.py", "w")
    f.write(rule["test_case"])
    f.close()
    cmd = ["python", "tmp.py"]
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
    if rule["premise"] in output.decode("utf-8"):
        print("dale")
        f = open("tmp.py", "w")
        f.write(rule["action"])
        f.close()
        output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
        print(output)
