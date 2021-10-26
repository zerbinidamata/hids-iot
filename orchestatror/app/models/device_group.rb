class DeviceGroup < ApplicationRecord
  has_and_belongs_to_many :script
  has_and_belongs_to_many :rule, optional: true
  accepts_nested_attributes_for :rule


  has_many :device

  def add_scripts(device_group, scripts)
    scripts.each do |script|
      @script = Script.find(script)
      device_group.script << @script
    end
  end

  def add_rules(device_group, rules)
    rules.each do |rule|
      @rule = Rule.find(rule)
      device_group.rule << @rule
    end
  end
end
