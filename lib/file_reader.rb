class FileReader

  # No input
  #
  def initialize
  end

  # Input: (String)
  #
  # Accepts the name of the file to open and read. Returns the data as an array
  # with each line a separate element of the array.
  def readFile(fileName)
    begin
    f = File.open(fileName, "r")
    contents = f.readlines()
    f.close
    rescue
      return nil
    end
    return contents
  end
end
