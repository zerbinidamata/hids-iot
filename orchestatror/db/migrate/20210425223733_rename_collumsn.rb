class RenameCollumsn < ActiveRecord::Migration[6.1]
  def change
    rename_column :devices, :device_groups_id, :device_group_id
  end
end
