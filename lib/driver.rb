class Driver

  def initialize(name)
    @name = name
    @totalMiles = 0.0
    @totalTime = 0.0
    @avgSpeed = 0.0
  end

  def getTotalMiles
    @totalMiles
  end

  def update(hours, miles)
    @totalTime += hours
    @totalMiles += miles
    # puts "The avg speed is: #{@totalTime} + #"
    @avgSpeed = @totalMiles/@totalTime
    # puts @totalTime
    # puts @totalMiles
    # puts @avgSpeed
    # puts (39.1/0.8333333333).round
  end

  def getAvgSpeed
    @avgSpeed
  end

  def getName
    @name
  end
end
