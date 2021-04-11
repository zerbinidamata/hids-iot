class Script < ApplicationRecord
  has_and_belongs_to_many :action
  has_and_belongs_to_many :test_case
  # This is supposed to be used for shared rules via IPFS
  has_one_attached :script_uri
end
