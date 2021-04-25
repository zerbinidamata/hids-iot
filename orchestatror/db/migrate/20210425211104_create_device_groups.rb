class CreateDeviceGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :device_groups do |t|
      t.string :group_name

      t.timestamps
    end

    drop_join_table :devices, :scripts
    add_reference :device_groups, :devices, index: true

    create_join_table :device_groups, :scripts do |t|
      t.index :script_id
      t.index :device_group_id
    end
  end
end
