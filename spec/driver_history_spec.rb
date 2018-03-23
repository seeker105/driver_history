require './lib/driver_history'

RSpec.describe "DriverHistory:" do
  context 'basic functions' do
    before(:each) do
      @dh = DriverHistory.new
    end

    it "can get a difference between two different HH:MM time strings" do
      t1 = "12:30"
      t2 = "13:15"
      dif = @dh.getTimeDif(t1, t2)

      expect(dif).to eq(0.75)
    end


  end
end
