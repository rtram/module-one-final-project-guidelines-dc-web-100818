class Race < ActiveRecord::Base
  has_many :standings
  has_many :drivers, through: :standings

  def self.circuit_list
    Race.all.collect do |race|
      race.circuit
    end
  end

  def self.circ_count
    Race.circuit_list.each_with_object(Hash.new(0)) do |circuit, counts|
      counts[circuit] += 1
    end
  end

  def self.top_ten
    arr_of_ten = Race.circ_count.sort_by(&:last).reverse[0...10]
    arr_of_ten.collect {|circuit_count| circuit_count[0]}
  end

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

  #returns the winner string of race
  def race_winner
    "#{self.driver_names[0]} won the #{self.circuit}."
  end

  #returns array of all races instances for circuit object
  def circuit_races
    Race.all.select {|race| race.circuit == self.circuit}
  end

  #USER CLI OPTION
  def number_of_races_held
    races = self.circuit_races
    "#{self.circuit} has had #{races.length} race(s) ever."
  end

  #USER CLI OPTION
  def first_race_at_circuit
    dates = self.circuit_races.collect {|race| race.date}
    dates.sort[0]
  end

end
