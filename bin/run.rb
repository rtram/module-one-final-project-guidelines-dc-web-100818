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


def driver_or_circuits(input)
  if ["F1 Driver", "driver", "DRIVER", "drivers", "DRIVERS"].include? (input)
    puts "Please enter a driver name."
    input = gets.chomp
    driver_selection = Driver.driver_search(input)
    Driver.run_driver(driver_selection)
  elsif ["Circuit", "circuit", "CIRCUIT", "Circuits", "circuits"].include? (input)
    puts "Please enter a circuit name."
    input = gets.chomp
    circuit_search(input)
    # run_race
  end
end

def runner
greeting

category_prompt

input = user_input

driver_or_circuits(input)


end

#runner



binding.pry
0
