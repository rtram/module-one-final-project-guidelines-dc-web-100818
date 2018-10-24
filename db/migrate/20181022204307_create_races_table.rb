class CreateRacesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.integer :circuit_id
      t.string :circuit_name
      t.date :date
    end
  end
end
