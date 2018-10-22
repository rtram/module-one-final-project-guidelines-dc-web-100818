class CreateStandingsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :standings do |t|
      t.integer :driver_id
      t.integer :race_id
      t.integer :points
      t.boolean :wins
    end
  end
end
