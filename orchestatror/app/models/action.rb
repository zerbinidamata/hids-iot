class Action < ApplicationRecord
  has_and_belongs_to_many :script
  has_one :rule

  def add_scripts(action, scripts)
    scripts.each do |script|
      @script = Script.find(script)
      action.script << @script
    end
  end
end
