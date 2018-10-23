class Race < ActiveRecord::Base
  has_many :standings
  has_many :drivers, through: :standings
end
