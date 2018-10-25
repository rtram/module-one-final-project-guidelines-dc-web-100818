require_relative '../config/environment'


  def greeting
    # puts
    # "______                        _         __    _____      _        _
    # |  ___|                       | |       /  |  |  _  \    | |      | |
    # | |_ ___  _ __ _ __ ___  _   _| | __ _  `| |  | | | |___ | |_ ____| |__   ____ ___  ___
    # |  _/ _ \|  __|  _   _ \| | | | |/ _  |  | |  | | | / _  | __ / _ |  _  \/ _  / __|/ _  \
    # | || (_) | |  | | | | | | |_| | | (_| | _| |_ | |/ / (_| | || (_| | |_) | (_| \__ \  __/
    # \_| \___/|_|  |_| |_| |_|\__,_|_|\__,_| \___/ |___/ \__,_|\__\__,_|_.__/ \__,_|___/\___|
    #
    # "

    puts "Welcome to the Formula 1 Database!"
    puts ""
    puts "Your number one source for Formula 1!"
    puts ""
  end

  def category_prompt
    puts "Are you looking for more information about a F1 Driver or a Circuit?"
    puts "If not, type 'exit' to leave database."
  end

  def main_menu
    category_prompt
    input = gets.chomp
    if ["F1 Driver", "driver", "DRIVER", "drivers", "DRIVERS"].include? (input)
      input = nil
      until input == "exit"
        input = Driver.driver_search
      end
      input
    elsif ["Circuit", "circuit", "CIRCUIT", "Circuits", "circuits"].include? (input)
      input = nil
      until input == "exit"
        input = Circuit.circuit_search
      end
      input
    elsif input == "exit"
      input
    end
  end

  def goodbye
    puts "Goodbye!"
  end

  def runner
    greeting

    input = nil
    while input != "exit"
      input = main_menu
    end

    goodbye
  end

binding.pry
0
