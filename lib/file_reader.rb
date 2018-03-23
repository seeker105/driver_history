class FileReader
  def initialize
  end

  # def readFile(fileName)
  #   begin
  #     f = File.open(@fileName, "r")
  #     contents = f.readLines
  #   rescue
  #     contents = nil
  #   end
  #   return contents
  # end

  def readFile(fileName)
    f = File.open(fileName, "r")
    contents = f.readlines()
    f.close
    return contents
  end
end
