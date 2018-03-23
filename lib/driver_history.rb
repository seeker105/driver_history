require "./lib/driver"
require "./lib/file_reader"
require "date"

class DriverHistory

  # def initialize
  #   @drivers = {}
  #   data = readFile
  #   data = nil
  #   if data == nil
  #     puts "A problem occured when loading file. Try again"
  #   else
  #     processData(data)
  #     generateReport
  #   end
  # end

  def initialize
    @drivers = {}
    if ARGV[0] && FileTest.exist?(ARGV[0])
      readFile
      generateReport
    else
      puts "The was a problem reading the file. Try again."
    end
  end

  # def readFile
  #   reader = FileReader.new
  #   contents = reader.readFile(ARGV[0])
  #   return contents
  # end

  # def processData(lines)
  #   lineNum = 0
  #   lines.each do |line|
  #     lineNum += 1
  #     line.strip!
  #     lineArr = line.split
  #     case lineArr[0]
  #     when "Driver"
  #       @drivers[lineArr[1]] = Driver.new(lineArr[1])
  #     when "Trip"
  #       addTrip(lineArr)
  #     else
  #       puts "Error: invalid entry in data file at line #{lineNum}"
  #     end
  #   end
  # end

  def readFile
    File.open(ARGV[0], 'r') do |f|
      lineNum = 0
      while line = f.gets
        lineNum += 1
        line.strip!
        lineArr = line.split
        case lineArr[0]
        when "Driver"
          @drivers[lineArr[1]] = Driver.new(lineArr[1])
        when "Trip"
          addTrip(lineArr)
        else
          puts "Error: invalid data in data file at line #{lineNum}"
        end
      end
    end
  end


  def addTrip(dataArr)
    driver = @drivers[dataArr[1]]
    hours = extractHours(dataArr[3]) - extractHours(dataArr[2])
    mins = extractMinutes(dataArr[3]) - extractMinutes(dataArr[2])
    hours += mins/60.0
    driver.update(hours, dataArr[4].to_f)
  end

  def extractHours(timeString)
    hours = timeString.slice(0,2)
    return hours.to_i
  end

  def extractMinutes(timeString)
    minutes = timeString.slice(3,2)
    return minutes.to_i
  end

  def generateReport
    sortedDrivers = @drivers.sort_by do |name, driver|
      -driver.getTotalMiles
    end
    sortedDrivers.each do |name, driver|
      reportLine = "#{name}: #{(driver.getTotalMiles).round} miles"
      if driver.getAvgSpeed > 0
        reportLine += " #{(driver.getAvgSpeed).round} mph"
      end
      puts reportLine
    end
  end

end


dh = DriverHistory.new
