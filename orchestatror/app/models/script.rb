class Script < ApplicationRecord
  has_and_belongs_to_many :action
  has_and_belongs_to_many :test_case
  # Storage for script files
  has_one_attached :file
end
