require "./lib/driver"
require "./lib/file_reader"
require "date"

class DriverHistory

  # No input
  #
  def initialize
    @drivers = {}
  end

  # Input: (String) name of input file to read
  # Returns: (String) newline delimited report of driving miles and average speed
  #
  # Accepts the name of the file to read as input. Goes through the file data
  # line by line and either creates a new Driver or adds Trip data to an existing
  # Driver. In the input file all the Drivers must be named (created) before
  # any Trip data is listed. If an input line does not start with "Driver" or
  # "Trip" the method will print an error message with the line number. Calls the
  # `generateReport` method at the end to create the report.
  def processFile(fileName)
    reader = FileReader.new
    lines = reader.readFile(fileName)
    if lines
      lines.each_with_index do |line, index|
        line.strip!
        lineArr = line.split
        case lineArr[0]
        when "Driver"
          @drivers[lineArr[1]] = Driver.new(lineArr[1])
        when "Trip"
          addTrip(lineArr)
        else
          puts "Error: invalid data in data file at line #{index + 1}"
        end
      end
    else
      puts "Error: There was an error loading the file. Try again."
    end
    generateReport
  end

  # Input: (Array) format: ["DriverName", "StartTime", "EndTime", "MilesTraveled"]
  # Modifies: @drivers instance variable
  #
  # Takes an array of strings in the format ["DriverName", "StartTime", "EndTime",
  # "MilesTraveled"]. Drivers must already have been declared. Times are 24-hour
  # clock format HH:MM. EndTime must be after StartTime.
  def addTrip(dataArr)
    driver = @drivers[dataArr[1]]
    hours_dif = getTimeDif(dataArr[2], dataArr[3])
    driver.update(hours_dif, dataArr[4].to_f)
  end

  # Input: (String, String) format: HH:MM, HH:MM
  # Returns: time difference in fractional hours
  #
  # Takes to strings expressing 24-hour times in the format HH:MM. Subtracts the
  # earlier time from the later to get the difference. If later is before earlier
  # it will result in a negative value.
  def getTimeDif(earlier, later)
    earlier = Time.new(2000,1,1,earlier.slice(0,2).to_i, earlier.slice(3,2).to_i)
    later = Time.new(2000,1,1,later.slice(0,2).to_i, later.slice(3,2).to_i)
    return (later - earlier)/3600.0
  end

  # Returns: (String) A newline delimited report of Drivers total miles and
  #          average speed
  #
  # Accesses the instance Hash of Drivers and generates a report of their total
  # miles driven and average speed. Average speed is calculated from total
  # distance traveled divided by total time traveled. Results are sorted in
  # descending order of total miles driven. Returns a string with newlines
  # separating Drivers.
  def generateReport
    report = ""
    sortedDrivers = @drivers.sort_by do |name, driver|
      -driver.getTotalMiles
    end
    sortedDrivers.each do |name, driver|
      reportLine = "#{name}: #{(driver.getTotalMiles).round} miles"
      if driver.getAvgSpeed > 0
        reportLine += " #{(driver.getAvgSpeed).round} mph\n"
      end
      report += reportLine
    end
    puts report
    return report
  end

end


if __FILE__ == $0
  if ARGV[0] && FileTest.exist?(ARGV[0])
    dh = DriverHistory.new
    report = dh.processFile(ARGV[0])
  else
    puts "There was a problem loading the file. Try again."
  end
end
