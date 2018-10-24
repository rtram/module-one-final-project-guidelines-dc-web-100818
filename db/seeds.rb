require "csv"
require 'pry'


CSV.foreach("lib/csv/drivers.csv") do |row|
  Driver.create(
    id: row[0],
    first_name: row[4],
    last_name: row[5],
    date_of_birth: row[6],
    nationality: row[7]
  )
end

CSV.foreach("lib/csv/races.csv") do |row|
  Race.create(
    id: row[0],
    circuit_id: row[3],
    circuit_name: row[4],
    date: row[5]
  )
end

CSV.foreach("lib/csv/standings.csv") do |row|
  Standing.create(
    id: row[0],
    driver_id: row[2],
    race_id: row[1],
    wins: row[6]
  )
end

CSV.foreach("lib/csv/circuits.csv") do |row|
  Circuit.create(
    id: row[0],
    name: row[2],
    city: row[3],
    country: row[4]
  )
end
