class Driver < ActiveRecord::Base
  has_many :standings
  has_many :races, through: :standings
end
