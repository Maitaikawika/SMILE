class Rosecrucian 
  include ActiveModel::Model
  attr_accessor :month, :day, :year

  VALID_MONTHDAY_REGEX = /[0-9]{2}/
  VALID_YEAR_REGEX = /[0-9]{4}/

  validates :month, presence: true, length: { is: 2 },
                    format: { with: VALID_MONTHDAY_REGEX }
  validates :day, presence: true, length: { is: 2 },
                    format: { with: VALID_MONTHDAY_REGEX }
  validates :year, presence: true, length: { is: 4 },
                    format: { with: VALID_YEAR_REGEX }

  def self.periods(yr, mnth, dy)

    require 'date'

    startdate = Date.new(yr.to_i, mnth.to_i, dy.to_i)
    return(periods_from(startdate))
  end

  def self.has_leapday?(time_pt)
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

  def self.periods_from(this_pt_in_time)
    # Takes a date as input, divides the ensuing year into 7 equal parts
    # and prints to standard out the list of start and end dates of each.

    thelist = {}
    therange = ""
    period = 1

    until period > 7 do
      therange = "#{this_pt_in_time} - "
      if period == 7
        this_pt_in_time += 52
      else
        this_pt_in_time += 51
      end
      if has_leapday?(this_pt_in_time)
        this_pt_in_time += 1
      end
      therange << "#{this_pt_in_time}"
      thelist["#{period}"] = therange
      period += 1
      this_pt_in_time += 1
    end
    return(thelist)
  end
end
