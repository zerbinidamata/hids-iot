class DeviceReportsConsumer < Racecar::Consumer
  subscribes_to 'devices-reports'

  def process(message)
    puts "Received message: #{message.value}"
  end
end
