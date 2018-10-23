class Standing < ActiveRecord::Base
  belongs_to :driver
  belongs_to :race
end
