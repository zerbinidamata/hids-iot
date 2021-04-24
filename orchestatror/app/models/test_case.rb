class TestCase < ApplicationRecord
  has_and_belongs_to_many :script
  belongs_to :rule

  def add_scripts(test_case, scripts)
    scripts.each do |script|
      @script = Script.find(script)
      test_case.script << @script
    end
  end
end
