class CreateRacesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.string :circuit
      t.date :date      
    end
  end
end
