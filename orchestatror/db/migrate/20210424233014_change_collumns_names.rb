class ChangeCollumnsNames < ActiveRecord::Migration[6.1]
  def change
    rename_column  :actions, :name, :action_name
    rename_column  :test_cases, :name, :test_case_name
  end
end
