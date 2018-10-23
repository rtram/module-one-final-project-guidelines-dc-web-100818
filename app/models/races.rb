class Race < ActiveRecord::Base
  has_many :standings
  has_many :drivers, through: :standings

  def driver_names
    self.drivers.collect do |driver|
      "#{driver.full_name}"
    end
  end

  def driver_nationality
    self.drivers.collect do |driver|
      driver.nationality
    end
  end

  def nationality_count
    self.driver_nationality.each_with_object(Hash.new(0)) do |nat, counts|
      counts[nat] += 1
    end
  end

  def race_winner
    "#{self.driver_names[0]} won the #{self.circuit}."
  end

  def circuit_races
    Race.all.select {|race| race.circuit == self.circuit}
  end

  def number_of_races_held
    races = self.circuit_races
    "#{self.circuit} has had #{races.length} race(s) ever."
  end

  def first_race_at_circuit
    dates = self.circuit_races.collect {|race| race.date}
    dates.sort[0]
  end

end
