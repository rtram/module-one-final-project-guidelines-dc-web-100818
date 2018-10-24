class Circuit < ActiveRecord::Base
  has_many :races
  has_many :standings, through: :races
end
