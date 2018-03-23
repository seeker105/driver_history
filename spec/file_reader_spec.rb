require "./lib/file_reader"

RSpec.describe FileReader, "FileReader" do
  before(:all) do
    @fakeName = "TestObj"

    class TestObj
      def initialize
        @fileArray = ["Driver Dan", "Driver Bob", "Driver Fred"]
      end

      def readlines
        @fileArray
      end

      def close
        #code
      end
    end
  end

  context "when reading file" do
    it "returns an array of the file lines" do

      @fakeName = "TestObj"
      allow(File).to receive(:open).with(@fakeName, "r").and_return(TestObj.new)

      reader = FileReader.new
      contents = reader.readFile(@fakeName)
      expect(contents.length).to eq(3)
      expect(contents[0]).to eq("Driver Dan")
      expect(contents[1]).to eq("Driver Bob")
      expect(contents[2]).to eq("Driver Fred")
    end
  end
end
