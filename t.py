import os
import subprocess

# sub = os.system('python -c "import sys; sys.exit(0)"; echo $?')
# output = subprocess.Popen(sub, stdout=subprocess.PIPE).communicate()
# print(output)

# cmd = ["python", "-c", '"print("output=1")"']
cmd = ["python", "t2.py"]
# output = run(cmd, capture_output=True).stdout
output = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]

print(output)