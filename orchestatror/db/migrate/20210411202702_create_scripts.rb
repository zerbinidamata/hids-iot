class CreateScripts < ActiveRecord::Migration[6.1]
  def change
    create_table :scripts do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
