class CreateJoinTableTestCasesScripts < ActiveRecord::Migration[6.1]
  def change
    create_join_table :test_cases, :scripts do |t|
      t.index :script_id
      t.index :test_case_id
    end
  end
end
