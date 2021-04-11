class Rule < ApplicationRecord
  has_and_belongs_to_many :action
  has_and_belongs_to_many :test_case
end
