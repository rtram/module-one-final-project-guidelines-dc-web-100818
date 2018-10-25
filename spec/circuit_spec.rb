require 'pry'
require_relative "../config/environment.rb"


describe "Circuit Methods" do
  before do
    @flatiron = Circuit.new(id: 1, name: "Flatiron Track", city: "DC", country: "United States")
    @flatironrace1 = Race.new(id: 1, circuit_id: 1, circuit_name: "Flatiron Track", date: 2018-10-25)
  end


  it "returns the circuit location" do
    expect(@flatiron).to be_a(Circuit)
    expect(@flatiron.circuit_by_location).to eq("Flatiron Track is located in DC, United States.")
  end

  it "return the name of the circuit " do
    expect(@flatiron.name).to eq("Flatiron Track")
  end
end
