Data Structures:
Obviously, in a real application we would save the data into a database. Because of the small scope of the problem I saved the data in a Ruby Hash. The Trip information uses Strings (names) to match Trip data with Drivers so indexing the data by name seemed like an obvious choice.

Hashes are unsorted by design, but Ruby's Hash includes the Enumerable module which lets us call `sort_by` to return a sorted array. I had to define a simple custom sort because we have a String-Object pair and the sort needed to know how we want the objects compared (by totalMiles).

I created Drivers as objects because they need to save state. They need to remember how many miles and how much time has already been added to them. And they need to be sortable based on their state.

File I/O responsibilities are typically extracted out into a separate module/object. I wanted to follow production quality structure as much as possible, so I put it into a separate object. This also allows me to keep the error prone code separate from the rest of the program.

Error Handling:
Keeping the file access code separate lets me catch any errors and return nil if it fails. The nil return is the signal to print an error message to the user.

The `processFile` method could have been much shorter if we were certain there were no errors in the input. I could have used an `if "Driver" do ... else ...(handle Trip)` but because we're dealing with risk I needed a catch all for anything other than valid data; hence the `case` statement.

I put a check for the existence of the file name and the actual file in order to prevent users from seeing a crash if they forgot to specify the file.

Other Decisions:
I decided to pass in the file name from the command line for simplicity. This meant that the program had to activate and run to completion in a single step.

Using Ruby's date/time objects always creates a timestamp that includes a date. I had to put in a dummy date (Jan 1 2000) to create the timestamp correctly. This gave me timestamps that could be subtracted from each other without having to worry about string processing.

The `generateReport` method also returns the report in order to simplify testing. 
