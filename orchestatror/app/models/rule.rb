class Rule < ApplicationRecord
  has_and_belongs_to_many :action
  has_and_belongs_to_many :test_case

  def add_actions(rule, actions)
    actions.each do |action|
      rule.actions << action
    end
  end

  def add_test_cases(rule, test_cases)
    test_cases.each do |test_case|
      rule.test_cases << test_case
    end
  end
end
