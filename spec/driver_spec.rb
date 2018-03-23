require './lib/driver'

RSpec.describe "Driver:" do
  context 'during initialization it' do
    it "Can create a new Driver with a given name" do
      d = Driver.new("Fred")

      expect(d.getName).to eq("Fred")
      expect(d.getTotalMiles).to eq(0)
      expect(d.getAvgSpeed).to eq(0)
    end

  end

  context "during operation it" do
    it "can accept time and mileage data" do
      d = Driver.new("Bob")
      hours = 2
      miles = 20

      d.update(hours, miles)
      expect(d.getTotalMiles).to eq(20)
      expect(d.getAvgSpeed).to eq(10)
    end

    it "can update after data is added" do
      d = Driver.new("Bob")
      hours = 2
      miles = 20

      d.update(hours, miles)
      expect(d.getTotalMiles).to eq(20)
      expect(d.getAvgSpeed).to eq(10)

      hours = 8
      miles = 2
      d.update(hours, miles)
      expect(d.getTotalMiles).to eq(22)
      expect(d.getAvgSpeed).to eq(2.2)
    end
  end

end
