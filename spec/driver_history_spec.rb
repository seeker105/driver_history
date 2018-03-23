require './lib/driver_history'
require './lib/file_reader'

RSpec.describe DriverHistory, "DriverHistory:" do
  before(:all) do
    @fakeName = "TestObj"

    class TestObj
      def initialize
        @fileArray = ["Driver Dan", "Driver Bob", "Driver Fred",
                      "Trip Dan 07:00 21:00 99.0",
                      "Trip Dan 10:00 12:00 25.5",
                      "Trip Fred 13:00 18:00 7.9"]
      end

      def readlines
        @fileArray
      end

      def setFileArray(array)
        @fileArray = array
      end

      def close
      end
    end
  end

  context 'functions' do
    before(:each) do
      @dh = DriverHistory.new
    end

    it "can get a difference between two different HH:MM time strings" do
      t1 = "12:30"
      t2 = "13:15"
      dif = @dh.getTimeDif(t1, t2)

      expect(dif).to eq(0.75)
    end

    it "can generate a hash of drivers with their data" do
      allow(File).to receive(:open).with(@fakeName, "r").and_return(TestObj.new)

      @dh.processFile(@fakeName)
      drivers = @dh.instance_variable_get(:@drivers)
      expect(drivers.length).to eq(3)
      expect(drivers["Dan"].getName).to eq("Dan")
      expect(drivers["Dan"].getTotalMiles).to eq(124.5)
      expect(drivers["Bob"].getName).to eq("Bob")
      expect(drivers["Bob"].getTotalMiles).to eq(0)
      expect(drivers["Fred"].getName).to eq("Fred")
      expect(drivers["Fred"].getTotalMiles).to eq(7.9)
    end

    it "outputs expected data to stdout" do
      allow(File).to receive(:open).with(@fakeName, "r").and_return(TestObj.new)

      expect(@dh.processFile(@fakeName)).to eq("Dan: 125 miles 8 mph\nFred: 8 miles 2 mph\nBob: 0 miles")
    end
  end
end
