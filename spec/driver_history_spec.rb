require './lib/main'

RSpec.describe "Main:" do
  context 'basic functions' do
    before(:each) do
      @dh = DriverHistory.new
    end

    it "can extract hours from HH:MM" do
      hours = @dh.extractHours("07:43")
      expect(hours).to eq(7)

      hours = @dh.extractHours("14:35")
      expect(hours).to eq(14)
      #Note: because we are using this value 
    end
  end
end
