import requests

url = "http://localhost:8000/deliver_rule_to_group"
data = {
    "group_id": 1,
"rule": "rule1",
}
res = requests.post(url, data=data)

print(res.json())
