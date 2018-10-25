class Circuit < ActiveRecord::Base
  has_many :races
  has_many :standings, through: :races

#COMMAND LINE METHODS

  def self.circuit_search
      Circuit.circuit_search_prompt
      input = gets.chomp
      input_integer = input.to_i
      if input_integer.between?(1,10)
        circuit_obj = Circuit.circuit_obj_return(input_integer)
        circuit_obj.circuit_query_until_loop
      elsif input_integer == 11
        circuit_obj = Circuit.circuit_extended_search
        circuit_obj.circuit_query_until_loop
      elsif input == "exit"
        return "exit"
      end
  end

  def self.circuit_search_prompt
    puts "Below is a list of the top ten most popular circuits.  Enter the number of the circuit you want."
    puts "If not, type 'exit' to leave database."
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


    def circuit_query_until_loop
      input = nil
      until ["back", "exit"].include? input
        input = self.circuit_query
        input
      end
      return input
    end

  def circuit_query_prompt
    puts "What would you like know about #{self.name}? Select a number below."
    puts "1. How many races has taken place at #{self.name}?"
    puts "2. When was the first race held at #{self.name}?"
    puts "3. When was the most recent race held at #{self.name}?"
    puts "-----------------------------------------"
    puts "4. Go back to the Circuit Search to look for another circuit."
    puts "5. Exit database."
  end

  def circuit_query
    self.circuit_query_prompt
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
      return "back"
    elsif input == "5"
      return "exit"
    else
      puts "-----------------------------------------"
      puts "Oops that is not an option, please try again."
      puts "-----------------------------------------"
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
