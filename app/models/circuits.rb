class Circuit < ActiveRecord::Base
  has_many :races
  has_many :standings, through: :races

#COMMAND LINE METHODS

  def self.circuit_search
    input = nil
    until input == "exit"
      Circuit.circuit_search_prompt
      input = gets.chomp
      input_integer = input.to_i
      if input_integer.between?(1,10)
        circuit_obj = Circuit.circuit_obj_return(input_integer)
        Circuit.run_circuit(circuit_obj)
      elsif input_integer == 11
        circuit_obj = Circuit.circuit_extended_search
        Circuit.run_circuit(circuit_obj)
      elsif input == "exit"
        return "exit"
      end
    end
  end
  

  def self.run_circuit(circuit)
    puts "What would you like know about #{circuit.name}? Select a number below."
    puts "1. How many races has taken place at #{circuit.name}?"
    puts "2. When was the first race held at #{circuit.name}?"
    puts "3. When was the most recent race held at #{circuit.name}?"
    puts "-----------------------------------------"
    puts "Type 'exit' to go back to the circuit menu."
    circuit.circuit_query
  end

  def circuit_query
    input = gets.chomp
    if input == "1"
      puts "-----------------------------------------"
      puts self.race_count
      puts "-----------------------------------------"
      Circuit.run_circuit(self)
    elsif input == "2"
      puts "-----------------------------------------"
      puts self.first_race
      puts "-----------------------------------------"
      Circuit.run_circuit(self)
    elsif input == "3"
      puts "-----------------------------------------"
      puts self.most_recent_race
      puts "-----------------------------------------"
      Circuit.run_circuit(self)
    elsif input == "exit"
      return "exit"
    else
      puts "-----------------------------------------"
      puts "Oops that is not an option, please try again."
      puts "-----------------------------------------"
      Circuit.run_circuit(self)
    end
  end




#INSTANCE METHODS --------------------------------------------------------------
  def race_count
     "#{self.races.length} races have occurred at #{self.name}."
  end

  def first_race
    "The first race at #{self.name} was on #{self.circuit_by_date[0].date}."
  end

  def most_recent_race
    "The most recent date at #{self.name} was on #{self.circuit_by_date[-1].date}."
  end


#HELPER METHODS ----------------------------------------------------------------

  def self.circuit_search_prompt
    puts "Below is a list of the top ten most popular circuits.  Enter the number next to the circuit you want, or type 'other' for the full list of circuits."
    puts "-----------------------------------------"
    Circuit.top_ten.each_with_index do |circ, index|
      puts "#{index + 1}. #{circ.name}"
    end
    puts "-----------------------------------------"
    puts "11. Full List of Circuits"
    puts "-----------------------------------------"
    puts "Enter 'exit' to go back to the main menu."
  end

  def self.top_ten
    Circuit.circuit_sort[0...10]
  end

  def self.circuit_sort
    sorted_circuits = Circuit.all.sort_by {|circuit| circuit.races.length}
    sorted_circuits.reverse
  end

  def self.circuit_obj_return(input)
    circuit_obj = Circuit.circuit_sort[input-1]
    puts "You have selected #{circuit_obj.name}!"
    circuit_obj
  end

  def self.circuit_extended_search
    puts "-----------------------------------------"
    Circuit.circuit_sort.each_with_index do |circ, index|
      puts "#{index + 1}. #{circ.name}"
    end
    puts "-----------------------------------------"
    input = gets.chomp
    input_integer = input.to_i
    if input_integer.between?(1,73)
      circuit_obj = Circuit.circuit_obj_return(input_integer)
      circuit_obj
    else
      puts "Oops that is not an option, please try again."
      Circuit.circuit_extended_search
    end
  end

  def circuit_by_date
    self.races.sort_by {|race| race.date}
  end

end
