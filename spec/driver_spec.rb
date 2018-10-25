require 'pry'
require_relative "../config/environment.rb"

describe "Driver Methods" do
  before do
    @anna = Driver.new(first_name: "Anna", last_name: "Conaway", date_of_birth: 1990-11-19, nationality: "American")
    @robin = Driver.new(first_name: "Robin", last_name: "Tram", date_of_birth: 1991-11-11, nationality: "American")
  end

  it "returns the driver's full name" do
    expect(@anna).to be_a(Driver)
    expect(@anna.full_name).to eq("Anna Conaway")
    expect(@robin.full_name).to eq("Robin Tram")
  end
end
