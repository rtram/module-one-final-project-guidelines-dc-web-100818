class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings

  #How many wins does a driver have
  def wins
    win_arr = self.standings.select {|result| result.wins == true}
    "#{self.first_name} #{self.last_name} has #{win_arr.length} wins."
  end

  def losses
    loss_arr = self.standings.select {|result| result.wins == false}
    "#{self.first_name} #{self.last_name} has #{loss_arr.length} loss(es)."
  end


end
