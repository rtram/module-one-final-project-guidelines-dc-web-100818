class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings

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
    won_races.select do |race|
      race.date.year == year
    end
    # if won_races.length > 0
    #   "#{self.first_name} #{self.last_name} won #{won_races.length} in #{year}."
    # else
    #   "#{self.first_name} #{self.last_name} did not win any races in #{year}."
    # end
  end

  def self.driver_search(input)
    driver = Driver.select("id").where(["first_name LIKE ? OR last_name LIKE ?", "%#{input}%", "%#{input}%"])
    if driver.length == 1
      driver_obj = Driver.find(driver[0].id)
      puts "#{driver_obj.full_name} has been found!"
      driver_obj
    elsif driver.length > 1
      puts "The following drivers have been found!"
      puts "Please enter the number next to the driver you meant."
      driver_obj = multiple_drivers_logic(driver)
      binding.pry
      driver_obj
    end
  end

  def self.multiple_drivers_logic(driver)
    multi_driver_arr = driver.collect do |n|
      Driver.find(n.id)
    end
    multi_driver_arr.each_with_index do |n, index|
      puts "#{index + 1}. #{n.full_name}"
    end
    input = user_input.to_i
    driver_obj = multi_driver_arr[input - 1]
      return driver_obj
  end

  # def run_driver(driver)
  #   puts "Driver Commands"
  #   puts ""
  # end


end
