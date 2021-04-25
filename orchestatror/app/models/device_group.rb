class DeviceGroup < ApplicationRecord
  has_and_belongs_to_many :script
  has_many :device

  def add_scripts(device, scripts)
    scripts.each do |script|
      @script = Script.find(script)
      device.script << @script
    end
  end
end
