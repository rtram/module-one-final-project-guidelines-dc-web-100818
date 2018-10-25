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


def driver_or_circuits
  input = nil
  until input == "exit"
    category_prompt
    input = user_input
    if ["F1 Driver", "driver", "DRIVER", "drivers", "DRIVERS"].include? (input)
      Driver.driver_search
    elsif ["Circuit", "circuit", "CIRCUIT", "Circuits", "circuits"].include? (input)
      Circuit.circuit_search
    end
  end
end

def main_menu
  driver_or_circuits
end

def runner
  greeting

  main_menu

end

lewis = Driver.all[0]

binding.pry
0
