import json
import requests
import argparse
import yaml
import os


def generate_provision_file(scripts):
    cwd = os.getcwd()
    action_scripts = os.listdir(f"{cwd}/hids_client/scripts/actions")
    test_scripts = os.listdir(f"{cwd}/hids_client/scripts/test_cases")
    all_scripts = test_scripts + action_scripts
    scripts_to_exclude = set(all_scripts).difference(set(scripts))
    with open("gateway.yaml", "r+") as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            print(line)
            if "rsync_opts" in line:
                for k, script in enumerate(scripts):
                    lines[
                        i + k + 1
                    ] = f"""            - "--exclude={cwd}/hids_client/scripts/{script}"\n"""
        f.seek(0)
        for line in lines:
            f.write(line)


def generate_host_data(devices_ip):
    hosts = dict()
    for i, ip in enumerate(devices_ip):
        entry = dict(ansible_host=ip, ansible_user="pi", ansible_password="raspberry")
        hosts[f"gateway{i}"] = entry
    data = dict(gateways=dict(hosts=hosts))
    with open("devices.yml", "w") as outfile:
        yaml.dump(data, outfile, default_flow_style=False)


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

    generate_host_data(devices_ip)
    generate_provision_file(scripts)
