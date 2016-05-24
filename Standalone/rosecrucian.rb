#
# Rosecrucian Yearly Cycle Calculator.
#
# David Herring, April 2016.
#
# Takes a date (Month, Day and Year, presumably a client's
# birthday for a given year) and starting on that date, divides
# the enusing year period into 7 equal 52 day periods, 
# and prints the start and end dates for each period.
# 
# Per the Rosecrucians, each period has certain signifcance for each of us
# and this utility eliminates the need to count days on a calendar to 
# determine which period of the client's year they are currently in.

require 'date'

def has_leapday?(time_pt)
  # Takes a date as input, determines if there is a leap day included
  # in the ensuing 52 day period, and if there is, returns true. Else false.
  #
  # If the year component is a leap year and month/day component is
  # greater than Jan 7 but less than Mar 1, then return true -- a leap
  # day falls within the 52 day period of this date.

  jan7 = Date.new(time_pt.year,1,7)
  mar1 = Date.new(time_pt.year,3,1)

  if time_pt.leap? && (time_pt > jan7 && time_pt < mar1)
    return true
  else
    return false
  end
end

def periods_from(this_pt_in_time)
  # Takes a date as input, divides the ensuing year into 7 equal parts
  # and prints to standard out the list of start and end dates of each.

  this = ["Zeroth", "First", "Second", "Third", "Fourth", "Fifth",
          "Sixth", "Seventh"]

  period = 1
  until period > 7 do
    print "#{this[period]} period:\t#{this_pt_in_time} - "
    if period == 7
      this_pt_in_time += 52
    else
      this_pt_in_time += 51
    end
    if has_leapday?(this_pt_in_time)
      this_pt_in_time += 1
    end
    print "#{this_pt_in_time}.\n"
    period += 1
    this_pt_in_time += 1
  end
end

trap("SIGINT") { puts ""; puts ""; exit!}

while true
  puts ""
  puts "Answer the following questions or hit ctrl-c to quit."
  puts ""
  print "Enter Month (MM): "
  month = $stdin.gets.chomp.to_i
  print "Enter Day (DD): "
  day = $stdin.gets.chomp.to_i
  print "Enter Year (YYYY): "
  year = $stdin.gets.chomp.to_i
  puts ""
  
  startdate = Date.new(year, month, day)
  
  periods_from(startdate)
  puts ""
end
