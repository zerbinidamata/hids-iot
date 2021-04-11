class CreateTestCases < ActiveRecord::Migration[6.1]
  def change
    create_table :test_cases do |t|
      t.string :name

      t.timestamps
    end
  end
end
