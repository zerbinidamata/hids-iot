class CreateDeviceGroupRulesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :device_groups, :rules do |t|
      t.index :device_group_id
      t.index :rule_id
    end
  end
end
