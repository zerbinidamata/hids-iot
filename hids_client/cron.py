from crontab import CronTab
import os

cwd = os.getcwd()

cron = CronTab(user="root")
# cmd = get_rule_cmd(rule)
cmd = f"bash {cwd}/scripts/test_cases/check_mirai_port.sh && {cwd}/scripts/test_cases/check_telnet.sh && bash {cwd}/scripts/actions/kill_mirai_port.sh && {cwd}/scripts/test_cases/stop_telnet.sh"
job = cron.new(command=cmd)
job.setall("0 * * * *")
cron.write()