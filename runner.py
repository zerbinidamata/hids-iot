import subprocess

# def create_cron_task(script, periodicity):


def run_rule(rule):
    f = open("tmp.py", "w")
    f.write(rule["test_case"])
    f.close()
    cmd = ["python", "tmp.py"]
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
    print(output)
    if rule["premise"] in output.decode("utf-8"):
        print("dale")
        f = open("tmp.py", "w")
        f.write(rule["action"])
        f.close()
        output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
        print(output)
