from datetime import datetime
import os


def generate_report(message):
    now = datetime.now()
    filename = now.strftime("%d-%m-%Y")
    if os.path.exists(f"./reports/{filename}"):
        append_write = "a"  # append if already exists
    else:
        append_write = "w"  # make a new file if not
    f = open(f"./reports/{filename}", append_write)
    f.write(f"\n{message}")
    f.close()
