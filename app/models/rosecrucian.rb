class Rosecrucian 
  include ActiveModel::Model
  attr_accessor :birth_month, :birth_day, :month, :day, :year, :length

  validates :birth_month, :presence => { :message => "Cannot be blank" }
  validates :birth_day, :presence => { :message => "Cannot be blank" }

  def self.periods(bmnth, bday, yr, mnth, dy, lnth)

    require 'date'

    startdate = startdateprocessor(yr, mnth, dy)
    birthdate = birthdateprocessor(bmnth, bday, startdate)
    length = lengthprocessor(lnth)
    return(periods_from(startdate, birthdate, length))
  end

private

  def self.has_leapday?(time_pt)
    # Takes a date as input, determines if there is a leap day included
    # in the ensuing 52 day period, and if there is, returns true. Else false.
    #
    # If the year component is a leap year and month/day component is
    # greater than Jan 7 but less than Mar 1, then return true -- a leap
    # day falls within the 52 day period of this date.

    tmpt = time_pt
  
    jan7 = Date.new(tmpt.year,1,7)
    mar1 = Date.new(tmpt.year,3,1)
  
    if tmpt.leap? && (tmpt > jan7 && tmpt < mar1)
      return true
    else
      return false
    end
  end

  def self.periods_from(this_pt_in_time, birthdate, numberofperiods)
    # Takes a date as input, divides the ensuing year into 7 equal parts
    # and prints to standard out the list of start and end dates of each.

    thelist = []
    therange = ""
    period = period_of(this_pt_in_time, birthdate)
    timepoint = period_start_date(birthdate, period)
    iteration = 1

    until iteration > numberofperiods do
      therange = "Period #{period}:   #{timepoint} - "
      if period == 7
        timepoint += 52
      else
        timepoint += 51
      end
      if has_leapday?(timepoint)
        timepoint += 1
      end
      therange << "#{timepoint}"
      thelist["#{iteration}".to_i] = therange
      period += 1
      if period > 7
        period = 1
      end
      iteration += 1
      timepoint += 1
    end
    return(thelist)
  end

  def self.period_start_date(bd, p)
    # Given a start date (bd) and which of 7 periods to look at (p),
    # returns a valid start date object for that period.

    period = 1

    if p == 1
      return(bd)
    end

    strtdate = bd 
    if has_leapday?(strtdate)
      endate = strtdate + 52
    else
      endate = strtdate + 51
    end

    until (period == p) do
      period += 1
      strtdate = endate + 1
      if has_leapday?(strtdate)
        endate = strtdate + 52
      else
        endate = strtdate + 51
      end
    end

    return(strtdate)
  end 

  def self.period_of(this_pt_in_time, birthdate)
    # Determines which of the 7 periods (starting at birthdate)
    # this_pt_in_time falls within.
    # Returns the period as an integer.

    period = 1

    if this_pt_in_time == birthdate
      return(period)
    end
    
    sdate = birthdate
    if has_leapday?(sdate)
      endate = sdate + 52
    else
      endate = sdate + 51
    end

    until ((this_pt_in_time >= sdate) && (this_pt_in_time < endate)) do
      period += 1
      if period > 7
        period = 1
      end

      sdate = endate
      if has_leapday?(sdate)
        endate += 52
      else
        endate += 51
      end

      if period == 7
        endate += 1
      end
    end

    return(period)
  end

  def self.startdateprocessor(year, month, day)
    # Determines proper values for year, month and day (if blank).
    # Returns a proper date object.

    date = Time.new

    if year.blank? 
      y = date.year
    else
      y = year.to_i
    end

    if month.blank?
      m = date.month
    else
      m = month.to_i
    end

    if day.blank?
      d = date.day
    else
      d = day.to_i
    end

    return(Date.new(y, m, d))
  end

  def self.birthdateprocessor(month, day, startdate)
    # Determines proper value for year, based on current day and start date.
    # Returns a proper date object.

    date = startdate

    if month.to_i > date.month
      year = date.year.to_i - 1
    else
      year = date.year.to_i
    end

    return Date.new(year, month.to_i, day.to_i)
  end

  def self.lengthprocessor(length)
    # Returns integer, default value 7 periods (1 year) if length is blank.

    if length.blank?
      l = 7 
    else
      l = length.to_i
    end

    return(l)
  end

end
