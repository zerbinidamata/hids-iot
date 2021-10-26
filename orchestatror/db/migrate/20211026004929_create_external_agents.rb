class CreateExternalAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :external_agents do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.string :api_secret, null: false
      t.string :policy_name, null: false

      t.timestamps
    end
  end
end
