class Device < ApplicationRecord
  belongs_to :device_group, optional: true
end
