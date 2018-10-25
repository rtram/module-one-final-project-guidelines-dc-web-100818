class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings

#2nd Level Down Driver Menu-----------------------------------------------------

  def self.driver_search
      puts "Please enter a driver name to search, type 'exit' to leave the database, or type 'back' to return to the main screen."
      puts "-----------------------------------------"
      input = gets.chomp
      puts "-----------------------------------------"
      driver = Driver.select("id").where(["first_name LIKE ? OR last_name LIKE ?",
        "%#{input}%", "%#{input}%"])
      if driver.length == 1
        driver_obj = Driver.find(driver[0].id)
        puts "#{driver_obj.full_name} has been found!"
        input = driver_obj.driver_query_until_loop
        return input
      elsif driver.length > 1
        puts "The following drivers have been found!"
        puts "Please enter the number next to the driver you meant."
        driver_obj = multiple_drivers_logic(driver)
        puts "You have selected #{driver_obj.full_name}!"
        input = driver_obj.driver_query_until_loop
        input
      elsif input == "back"
        return "back"
      elsif input == "exit"
        return "exit"
      else
        puts "#{input} does not exist in this database.  Please enter a valid name."
      end
    end


  def self.multiple_drivers_logic(driver)
    multi_driver_arr = driver.collect do |n|
      Driver.find(n.id)
    end
    multi_driver_arr.each_with_index do |n, index|
      puts "#{index + 1}. #{n.full_name}"
    end
    input = (gets.chomp).to_i
    driver_obj = multi_driver_arr[input - 1]
    driver_obj
  end

  #3rd Level Down Driver Stats Menu --------------------------------------------

  def driver_query_until_loop
    input = nil
    until ["back", "exit"].include? input
      input = self.driver_query
      input
    end
    return input
  end


  def driver_query
    self.query_prompt
    puts "-----------------------------------------"
    input = gets.chomp
    if input == "1"
      puts "-----------------------------------------"
      puts self.wins
      puts "-----------------------------------------"

    elsif input == "2"
      puts "-----------------------------------------"
      puts self.losses
      puts "-----------------------------------------"
    elsif input == "3"
      puts "-----------------------------------------"
      puts "Which year would you like to search?"
      puts "-----------------------------------------"
      input2 = gets.chomp
      puts self.wins_for_year(input2)
    elsif input == "4"
      puts "-----------------------------------------"
      puts self.nationality
      puts "-----------------------------------------"
    elsif input == "5"
      puts "-----------------------------------------"
      puts self.date_of_birth
      puts "-----------------------------------------"
    elsif input == "6"
      puts "-----------------------------------------"
      puts self.favorite_circuit
      puts "-----------------------------------------"
    elsif input == "7"
      return "back"
    elsif input == "8"
      return "exit"
    else
      puts "-----------------------------------------"
      puts "Oops that is not an option, please try again."
      puts "-----------------------------------------"
    end
  end

  def query_prompt
    puts "What would you like know about #{self.full_name}? Select a number below."
    puts ""
    puts "1. How many career wins does #{self.full_name} have?"
    puts "2. How many career losses does #{self.full_name} have?"
    puts "3. How many wins has #{self.full_name} had in a given year?"
    puts "4. What is #{self.full_name}'s nationality?"
    puts "5. What is #{self.full_name}'s' date of birth?"
    puts "6. Which circuit has #{self.full_name} raced on the most?"
    puts "7. Go back to the Driver Search to look for another driver."
    puts "8. Exit database."
  end


#INSTANCE METHODS --------------------------------------------------------------


  def wins
    win_arr = self.win_array
    "#{self.full_name} has #{win_arr.length} wins."
  end

  def losses
    loss_arr = self.standings.select {|result| result.wins == false}
    "#{self.full_name} has #{loss_arr.length} loss(es)."
  end

  def wins_for_year(year)
    win_arr = self.win_array
    arr = win_arr.collect {|win| win.race_id}
    won_races = self.races.select do |race|
        arr.include? (race.id)
    end
    won_races.select! do |race|
      race.date.year.to_s == year
    end
    if won_races.length > 0
      "#{self.first_name} #{self.last_name} won #{won_races.length} in #{year}."
    else
      "#{self.first_name} #{self.last_name} did not win any races in #{year}."
    end
  end

  def favorite_circuit
    arr = Driver.all[0].races.collect {|race| race.circuit_name}
    faves = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    sorted_faves = faves.sort_by(&:last).reverse
    "#{self.full_name}'s loves racing at the #{sorted_faves[0][0]}."
  end


#HELPER METHODS-----------------------------------------------------------------

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def win_array
    win_arr = self.standings.select {|result| result.wins == true}
  end
end
