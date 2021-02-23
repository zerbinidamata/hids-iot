import sys
import time
import os
import logging
import runner
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler


class LogHandler(PatternMatchingEventHandler):
    def process(self, event):
        runner.check_cron_output(event.src_path)

    def on_modified(self, event):
        print("file modified " + event.src_path)
        self.process(event)

    def on_created(self, event):
        print("file created" + event.src_path)
        self.process(event)

    def on_moved(self, event):
        print("file moved" + event.src_path)

    def on_deleted(self, event):
        print("file deleted" + event.src_path)


if __name__ == "__main__":
    cwd = os.getcwd()
    path = f"{cwd}/cron_rules/logs"
    observer = Observer()
    observer.schedule(LogHandler(), path, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    finally:
        observer.stop()
        observer.join()