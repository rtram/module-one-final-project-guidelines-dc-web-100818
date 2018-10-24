class CreateCircuitTable < ActiveRecord::Migration[5.0]
  def change
    create_table :circuits do |t|
      t.string :name
      t.string :city
      t.string :country
    end 
  end
end
