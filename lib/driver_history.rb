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
  end

  def processFile
    readFile
    generateReport
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
    hours_dif = getTimeDif(dataArr[2], dataArr[3])
    driver.update(hours_dif, dataArr[4].to_f)
  end

  def getTimeDif(earlier, later)
    earlier = Time.new(2000,1,1,earlier.slice(0,2).to_i, earlier.slice(3,2).to_i)
    later = Time.new(2000,1,1,later.slice(0,2).to_i, later.slice(3,2).to_i)
    return (later - earlier)/3600.0
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


if __FILE__ == $0
  if ARGV[0] && FileTest.exist?(ARGV[0])
    dh = DriverHistory.new
    dh.processFile
  else
    puts "There was a problem loading the file. Try again."
  end
end
