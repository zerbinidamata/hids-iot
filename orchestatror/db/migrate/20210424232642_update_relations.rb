class UpdateRelations < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :rules, :actions
    drop_join_table :rules, :test_cases
    add_reference :rules, :actions, index: true
    add_reference :rules, :test_cases, index: true
  end
end
