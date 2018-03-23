class Driver

  # Input: (String) Driver's name
  #
  # Requires the Driver's name as input
  def initialize(name)
    @name = name
    @totalMiles = 0.0
    @totalTime = 0.0
    @avgSpeed = 0.0
  end

  # Returns: (Float)
  #
  # The Driver's total miles driven
  def getTotalMiles
    @totalMiles
  end

  # Input (Float, Float)
  #
  # Accepts hours driven on a Trip and distance of that Trip. Adds the hours and
  # miles to the Driver's totals. Recalculates their average speed based on the
  # data
  def update(hours, miles)
    @totalTime += hours
    @totalMiles += miles
    @avgSpeed = @totalMiles/@totalTime
  end

  # Returns: (Float)
  #
  # The Driver's average Speed
  def getAvgSpeed
    @avgSpeed
  end

  # Returns: (String)
  #
  # The Driver's name
  def getName
    @name
  end
end
