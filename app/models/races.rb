class Race < ActiveRecord::Base
  has_many :standings
  has_many :drivers, through: :standings

  def driver_names
    self.drivers.collect do |driver|
      "#{driver.first_name} #{driver.last_name}"
    end
  end

  def driver_nationality
    self.drivers.collect do |driver|
      driver.nationality
    end
  end

  def nationality_count
    self.driver_nationality.each_with_object(Hash.new(0)) do |nat, counts|
      counts[nat] += 1
    end
  end

end
