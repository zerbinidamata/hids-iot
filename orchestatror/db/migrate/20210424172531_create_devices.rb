class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.string :device_ip

      t.timestamps
    end

    create_join_table :devices, :scripts do |t|
      t.index :device_id
      t.index :script_id

      t.timestamps
    end
  end
end
