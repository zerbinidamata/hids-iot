class CreateJoinTableRulesTestCases < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rules, :test_cases do |t|
      t.index :rule_id
      t.index :test_case_id
    end
  end
end
