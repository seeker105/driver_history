require './lib/driver_history'

RSpec.describe "DriverHistory:" do
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

    it "can generate a list of drivers " do
      # IO.stub(:readlines).and_return(["Driver Dan",
      #                                   "Driver Bob",
      #                                   "Driver Fred"])
      allow(File).to receive(:open).and_return("Driver Dan\nDriver Bob\nDriver Fred")
      @dh.readFile
      drivers = @dh.instance_variable_get(:@drivers)
      puts drivers
    end

  end
end
