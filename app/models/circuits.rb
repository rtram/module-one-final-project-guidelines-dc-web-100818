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



#HELPER METHODS
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
