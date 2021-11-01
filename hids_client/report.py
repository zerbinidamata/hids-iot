import reports_producer


# reports_producer.generate_report(
#   {
#       "message": f"Device 2 started execution for rule Check Mirai controller port com id 52",
#       "type": "rule",
#       "device_id": 2,
#       "name": "Check Mirai controller port",
#       "rule_id": 52,
#   }
# )



# reports_producer.generate_report(
#   {
#       "message": f"Device 2  has not found a match for test_case check_mirai_port. Action will not be executed.",
#       "type": "test_case",
#       "device_id": 2,
#       "name": "check_mirai_port",
#       "rule_id": 52,
#       "status": "not found",
#   }
# )


########################################################################################################################

# reports_producer.generate_report(
#   {
#       "message": f"Device 3 started execution for rule Check Mirai controller port com id 52",
#       "type": "rule",
#       "device_id": 3,
#       "name": "Check Mirai controller port",
#       "rule_id": 52,
#   }
# )



# reports_producer.generate_report(
#   {
#       "message": f"Device 3 sucessfully executed test_case check_mirai_port for rule Check Mirai controller port com id 52",
#       "type": "test_case",
#       "device_id": 3,
#       "name": "check_mirai_port",
#       "rule_id": 52,
#       "status": "success",
#   }
# )

# reports_producer.generate_report(
#           {
#               "message": f"Device 3 sucessfully executed action kill_mirai_port for rule Check Mirai controller port com id 52",
#               "type": "action",
#               "name": "kill_mirai_port",
#               "rule_id": 52,
#               "status": "success",
#           }
#       )

######################### Tangle #######################################################################################

reports_producer.generate_report(
  {
      "message": f"Device 5 started execution for rule Check Mirai controller port and Telnet from channel dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
      "type": "rule",
      "device_id": 5,
      "name": "Check Mirai controller port and Telnet",
      "channel": "dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
  }
)



reports_producer.generate_report(
  {
      "message": f"Device 5 sucessfully executed test_case check_mirai_port for rule Check Mirai controller port from channel dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
      "type": "test_case",
      "device_id": 5,
      "name": "check_mirai_port",
      "channel": "dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
      "status": "success",
  }
)

reports_producer.generate_report(
  {
      "message": f"Device 5 sucessfully executed test_case check_telnet for rule Check Mirai controller port and Telnet from channel dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
      "type": "test_case",
      "device_id": 5,
      "name": "check_telnet",
      "channel": "dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
      "status": "success",
  }
)

reports_producer.generate_report(
          {
              "message": f"Device 5 sucessfully executed action kill_mirai_port for rule Check Mirai controller port and Telnet from channel dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
              "type": "action",
              "device_id": 5,
              "name": "kill_mirai_port",
              "channel": "dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
              "status": "success",
          }
      )

reports_producer.generate_report(
          {
              "message": f"Device 5 sucessfully executed action stop_telnet for rule Check Mirai controller port and Telnet from channel dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
              "type": "action",
              "device_id": 5,
              "name": "stop_telnet",
              "channel": "dd2745470686973ec9c063b092284870baa0da6335bd896adf165b7bcc23735d0000000000000000",
              "status": "success",
          }
      )
