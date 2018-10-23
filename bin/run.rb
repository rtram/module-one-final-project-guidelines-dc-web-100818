require_relative '../config/environment'


def greeting
puts "Welcome to the Formula 1 Database!"
puts ""
puts "Your number one source for Formula 1!"
puts ""
end

def category_prompt
puts "Are you looking for more information about a F1 Driver or a Circuit?"
end

def user_input
  gets.chomp
end

def run_driver(driver)
  puts "Driver Commands"
  puts ""
end

def run_race
  puts "Race Commands"
end

def driver_or_circuits(input)
  if ["F1 Driver", "driver", "DRIVER", "drivers", "DRIVERS"].include? (input)
    puts "Please enter a driver name."
    input = gets.chomp
    driver_search(input)
    # run_driver
  elsif ["Circuit", "circuit", "CIRCUIT", "Circuits", "circuits"].include? (input)
    puts "Please enter a circuit name."
    input = gets.chomp
    circuit_search(input)
    # run_race
  end
end

def driver_search(input)
  driver = Driver.select("id").where(["first_name LIKE ? OR last_name LIKE ?", "%#{input}%", "%#{input}%"])
  if driver.length == 1
    driver_obj = Driver.find(driver[0].id)
    puts "#{driver_obj.full_name} has been found!"
    driver_obj
  end
  # binding.pry
end

def circuit_search(input)
end

def runner
greeting

category_prompt

input = user_input

driver_or_circuits(input)


end





binding.pry
0
