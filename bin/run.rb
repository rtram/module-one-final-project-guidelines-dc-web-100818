require_relative '../config/environment'

#1ST LEVEL DOWN: MAIN MENU------------------------------------------------------
  def main_menu
    greeting
    category_prompt
    input = gets.chomp
    if ["F1 Driver", "driver", "DRIVER", "drivers", "DRIVERS"].include? (input)
      input = nil
      until ["back", "exit"].include? input
        input = Driver.driver_search
      end
      input
    elsif ["Circuit", "circuit", "CIRCUIT", "Circuits", "circuits"].include? (input)
      input = nil
      until ["back", "exit"].include? input
        input = Circuit.circuit_search
      end
      input
    elsif input == "exit"
      input
    else
      puts "-----------------------------------------"
      puts "Invalid command, please type in 'driver' or 'circuit'.'"
      puts "-----------------------------------------"
    end
  end

#MAIN MENU HELPER METHODS-------------------------------------------------------

  def greeting
    font = TTY::Font.new(:doom)
    puts font.write("Formula    1")
    puts font.write(" Database")
    puts "Welcome to the Formula 1 Database!"
    puts ""
    puts "Your number one source for Formula 1!"
    puts ""
  end

  def category_prompt
    puts "Are you looking for more information about a F1 Driver or a Circuit?"
    puts "If not, type 'exit' to leave database."
  end

#GOODBYE METHOD USED IN THE RUNNER METHOD --------------------------------------

  def goodbye
    puts "Goodbye!"
  end

#RUNNER METHOD------------------------------------------------------------------
  def runner
    input = nil
    while input != "exit"
      input = main_menu
    end
    goodbye
  end
#-------------------------------------------------------------------------------
runner
0
