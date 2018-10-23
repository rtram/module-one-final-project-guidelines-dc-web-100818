class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings

  def win_array
    win_arr = self.standings.select {|result| result.wins == true}
  end

  def wins
    win_arr = self.win_array
    "#{self.first_name} #{self.last_name} has #{win_arr.length} wins."
  end

  def losses
    loss_arr = self.standings.select {|result| result.wins == false}
    "#{self.first_name} #{self.last_name} has #{loss_arr.length} loss(es)."
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

end
