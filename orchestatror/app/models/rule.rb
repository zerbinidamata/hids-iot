class Rule < ApplicationRecord
  has_and_belongs_to_many :device_group

  belongs_to :action
  belongs_to :test_case

  def add_actions(rule, actions)
    actions.each do |action|
      @action = Action.find(action)
      rule.action << @action
    end
  end

  def add_test_cases(rule, test_cases)
    test_cases.each do |test_case|
      @test_case = Action.find(test_case)
      rule.test_case << @test_case
    end
  end
end
