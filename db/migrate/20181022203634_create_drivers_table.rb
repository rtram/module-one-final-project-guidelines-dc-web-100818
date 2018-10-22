class CreateDriversTable < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :nationality
    end 
  end
end
