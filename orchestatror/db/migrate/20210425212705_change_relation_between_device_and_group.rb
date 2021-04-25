class ChangeRelationBetweenDeviceAndGroup < ActiveRecord::Migration[6.1]
  def change
    remove_column :device_groups, :devices_id

    add_reference :devices, :device_groups, index: true
  end
end
