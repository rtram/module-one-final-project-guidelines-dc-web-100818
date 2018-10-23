require "csv"
require 'pry'


CSV.foreach("/Users/flatironschool/development/final_project/module-one-final-project-guidelines-dc-web-100818/lib/csv/drivers.csv") do |row|
  Driver.create(
    id: row[0],
    first_name: row[4],
    last_name: row[5],
    date_of_birth: row[6],
    nationality: row[7]
  )
end

CSV.foreach("/Users/flatironschool/development/final_project/module-one-final-project-guidelines-dc-web-100818/lib/csv/races.csv") do |row|
# binding.pry
  Race.create(
    id: row[0],
    circuit: row[4],
    date: row[5]
  )
end

CSV.foreach("/Users/flatironschool/development/final_project/module-one-final-project-guidelines-dc-web-100818/lib/csv/standings.csv") do |row|
  # binding.pry
  Standing.create(
    id: row[0],
    driver_id: row[2],
    race_id: row[1],
    points: row[3],
    wins: row[6]
  )
end
