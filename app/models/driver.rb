class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings

#2nd Level Down Driver Menu-----------------------------------------------------

  def self.driver_search
      puts "Please enter a driver name, or type 'exit' to go back to the main screen."
      input = gets.chomp
      driver = Driver.select("id").where(["first_name LIKE ? OR last_name LIKE ?",
        "%#{input}%", "%#{input}%"])
      if driver.length == 1
        driver_obj = Driver.find(driver[0].id)
        binding.pry
        puts "#{driver_obj.full_name} has been found!"
        input = driver_obj.driver_query_until_loop
        return input
      elsif driver.length > 1
        puts "The following drivers have been found!"
        puts "Please enter the number next to the driver you meant."
        driver_obj = multiple_drivers_logic(driver)
        puts "You have selected #{driver_obj.full_name}!"
        input = driver_obj.driver_query_until_loop
        return input
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
      return "back"
    elsif input == "5"
      return "exit"
    else
      puts "-----------------------------------------"
      puts "Oops that is not an option, please try again."
      puts "-----------------------------------------"
    end
  end

  def query_prompt
    puts "What would you like know about #{self.full_name}? Select a number below."
    puts "1. How many career wins does #{self.full_name} have?"
    puts "2. How many career losses does #{self.full_name} have?"
    puts "3. How many wins has #{self.full_name} had in a given year?"
    puts "-----------------------------------------"
    puts "4. Go back to the Driver Search to look for another driver."
    puts "5. Exit database."
  end


#INSTANCE METHODS --------------------------------------------------------------

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def win_array
    win_arr = self.standings.select {|result| result.wins == true}
  end

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

end

#HELPER METHODS-----------------------------------------------------------------
