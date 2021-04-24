class ChangeForeignCollumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :rules, :test_cases_id, :test_case_id
    rename_column :rules, :actions_id, :action_id
  end
end
