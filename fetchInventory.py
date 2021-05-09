import json
import requests
import argparse


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--group_id", help="Enter group_id to provision")
    args = parser.parse_args()
    r = requests.get(f"http://localhost:3000/device_groups/{args.group_id}")
    data = json.loads(r.text)
    devices_ip = []
    scripts = []
    for device in data["device"]:
        devices_ip.append(device["device_ip"])
    for script in data["script"]:
        scripts.append(script["name"])
