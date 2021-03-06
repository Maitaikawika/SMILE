module RosecrucianHelper

  def periods(m, d, y)

    require 'date'

    startdate = Date.new(y.chomp.to_i, m.chomp.to_i, d.chomp.to_i)
    return(periods_from(startdate))
  end

private

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
    thelist = ""
    until period > 7 do
      thelist << "#{this[period]} period:\t#{this_pt_in_time} - "
      if period == 7
        this_pt_in_time += 52
      else
        this_pt_in_time += 51
      end
      if has_leapday?(this_pt_in_time)
        this_pt_in_time += 1
      end
      thelist << "#{this_pt_in_time}.\n"
      period += 1
      this_pt_in_time += 1
    end
    return(thelist)
  end
end
