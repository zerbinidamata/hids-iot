class CreateJoinTableActionsScripts < ActiveRecord::Migration[6.1]
  def change
    create_join_table :actions, :scripts do |t|
      t.index :action_id
      t.index :script_id
    end
  end
end
