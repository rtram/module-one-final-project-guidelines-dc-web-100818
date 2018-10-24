class Circuit < ActiveRecord::Base
  has_many :races
  has_many :standings, through: :races

  def self.circuit_search
    puts "-----------------------------------------"
    Circuit.top_ten.each_with_index do |circ, index|
      puts "#{index + 1}. #{circ.name}"
    end
      puts "-----------------------------------------"
      puts "11. Full List of Circuits"
      input = gets.chomp
      input_integer = input.to_i
      if input_integer.between?(1,10)
        circuit_obj = Circuit.circuit_obj_return(input_integer)
        circuit_obj
      elsif input_integer == 11
        Circuit.circuit_extended_search

      end
  end

  def self.run_circuit(circuit)
    puts "What would you like know about #{circuit.name}? Select a number below."
    puts "1. How many races has taken place at #{circuit.name}?"
    puts "2. When was the first race held at #{circuit.name}?"
    puts "3. When was the most recent race held at #{circuit.name}?"
    puts "4. Exit to main menu."

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
    elsif input == "4"
      main_menu
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
    binding.pry
  end

  def circuit_by_date
    self.races.sort_by {|race| race.date}
  end

end




# def self.driver_search(input)
#   driver = Driver.select("id").where(["first_name LIKE ? OR last_name LIKE ?", "%#{input}%", "%#{input}%"])
#   if driver.length == 1
#     driver_obj = Driver.find(driver[0].id)
#     puts "#{driver_obj.full_name} has been found!"
#     driver_obj
#   elsif driver.length > 1
#     puts "The following drivers have been found!"
#     puts "Please enter the number next to the driver you meant."
#     driver_obj = multiple_drivers_logic(driver)
#     puts "You have selected #{driver_obj.full_name}!"
#     driver_obj
#   end
# end
