class CreateJoinTableRulesActions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rules, :actions do |t|
      t.index :rule_id
      t.index :action_id
    end
  end
end
