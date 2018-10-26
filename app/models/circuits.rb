class Circuit < ActiveRecord::Base
  has_many :races
  has_many :standings, through: :races

#2ND LEVEL DOWN: CIRCUIT MENU --------------------------------------------------

  def self.circuit_search
    Circuit.circuit_search_prompt
    input = gets.chomp
    puts "-----------------------------------------"
    input_integer = input.to_i
    if input_integer.between?(1,10)
      circuit_obj = Circuit.circuit_obj_return(input_integer)
      circuit_obj.circuit_query_until_loop
    elsif input_integer == 11
      circuit_obj = Circuit.circuit_extended_search
      circuit_obj.circuit_query_until_loop
    elsif input == "back"
      return "back"
    elsif input == "exit"
      return "exit"
    end
  end

  def self.circuit_search_prompt
    puts "-----------------------------------------"
    puts "Below is a list of the top ten most popular circuits.  Please enter the number associated with a circuit below,"
    puts "type 'exit' to leave the database, or type 'back' to return to the main screen."
    puts "-----------------------------------------"
    Circuit.top_ten.each_with_index do |circ, index|
      puts "#{index + 1}. #{circ.name}"
    end
    puts "-----------------------------------------"
    puts "11. Full List of Circuits"
    puts "-----------------------------------------"
  end

  def self.circuit_obj_return(input)
    circuit_obj = Circuit.circuit_sort[input-1]
    puts "You have selected #{circuit_obj.name}!"
    circuit_obj
  end

  def self.circuit_extended_search
    Circuit.circuit_sort.each_with_index do |circ, index|
      puts "#{index + 1}. #{circ.name}"
    end
    puts "-----------------------------------------"
    input = gets.chomp
    puts "-----------------------------------------"
    input_integer = input.to_i
    if input_integer.between?(1,73)
      circuit_obj = Circuit.circuit_obj_return(input_integer)
      circuit_obj
    else
      puts "Oops that is not an option, please try again."
      Circuit.circuit_extended_search
    end
  end

#3RD LEVEL DOWN: CIRCUIT INFORMATION MENU---------------------------------------

  def circuit_query_until_loop
    input = nil
    until ["back1", "exit"].include? input
      input = self.circuit_query
      input
    end
    return input
  end

  def circuit_query_prompt
    puts "What would you like know about #{self.name}? Select a number below."
    puts ""
    puts "1. How many races has taken place at #{self.name}?"
    puts "2. When was the first race held at #{self.name}?"
    puts "3. When was the most recent race held at #{self.name}?"
    puts "4. Where is this circuit located?"
    puts "5. Who won the last race that took place at #{self.name}?"
    puts "6. Go back to the circuit list."
    puts "7. Exit database."
  end

  def circuit_query
    self.circuit_query_prompt
    puts "-----------------------------------------"
    input = gets.chomp
    if input == "1"
      puts "-----------------------------------------"
      puts self.race_count
      puts "-----------------------------------------"
    elsif input == "2"
      puts "-----------------------------------------"
      puts self.first_race
      puts "-----------------------------------------"
    elsif input == "3"
      puts "-----------------------------------------"
      puts self.most_recent_race
      puts "-----------------------------------------"
    elsif input == "4"
      puts "-----------------------------------------"
      puts self.circuit_by_location
      puts "-----------------------------------------"
    elsif input == "5"
      puts "-----------------------------------------"
      puts self.most_recent_winner
      puts "-----------------------------------------"
    elsif input == "6"
      return "back1"
    elsif input == "7"
      return "exit"
    else
      puts "-----------------------------------------"
      puts "Oops that is not an option, please try again."
      puts "-----------------------------------------"
    end
  end

#INSTANCE METHODS CALLED IN CIRCUIT INFORMATION MENU----------------------------
  def race_count
     "#{self.races.length} races have occurred at #{self.name}."
  end

  def first_race
    "The first race at #{self.name} was on #{self.circuit_by_date[0].date}."
  end

  def most_recent_race
    "The most recent date at #{self.name} was on #{self.circuit_by_date[-1].date}."
  end

  def circuit_by_location
    "#{self.name} is located in #{self.city}, #{self.country}."
  end

  def most_recent_winner
    winner = Driver.find(self.circuit_by_date[-1].standings[0].driver_id).full_name
    "The most recent winner at #{self.name} was #{winner}."
  end

#HELPER METHODS: USED THROUGHOUT CIRCUIT MODULE---------------------------------

  def self.top_ten
    Circuit.circuit_sort[0...10]
  end

  def self.circuit_sort
    sorted_circuits = Circuit.all.sort_by {|circuit| circuit.races.length}
    sorted_circuits.reverse
  end

  def circuit_by_date
    self.races.sort_by {|race| race.date}
  end
end
