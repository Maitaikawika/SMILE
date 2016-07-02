class Rosecrucian 
  include ActiveModel::Model
  attr_accessor :birth_month, :birth_day, :month, :day, :year, :length

  VALID_NAME_REGEX = /\A[a-zA-Z\s]+\z/
  VALID_MONTHDAY_REGEX = /\A([1-9]|1[0-2])\z/
  VALID_YEAR_REGEX = /[0-9]{4}/

  validates :birth_month, presence: true, length: { maximum: 2 },
            format: { with: VALID_MONTHDAY_REGEX,
            message: "Client's Birth Month, 1 - 12" }
  validates :birth_day, presence: true, length: { maximum: 2 },
            format: { with: VALID_MONTHDAY_REGEX,
            message: "Client's Birth Day, 1 - 31" }
  validates :month, length: { maximum: 2 },
            format: { with: VALID_MONTHDAY_REGEX,
            message: "Start of report, assumes current month if blank" }
  validates :day, length: { maximum: 2 },
            format: { with: VALID_MONTHDAY_REGEX,
            message: "Start of report, assumes today if blank" }
  validates :year, length: { is: 4 },
            format: { with: VALID_YEAR_REGEX,
            message: "Start of report, assumes this year if blank" }
  validates :length, length: { maximum: 2 },
            format: { with: VALID_MONTHDAY_REGEX,
            message: "Number of periods to cover in report, 1 - 99" }

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
  
    jan7 = Date.new(time_pt.year,1,7)
    mar1 = Date.new(time_pt.year,3,1)
  
    if time_pt.leap? && (time_pt > jan7 && time_pt < mar1)
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

    startdate = bd 
    if has_leapday?(startdate)
      endate = startdate + 52
    else
      endate = startdate + 51
    end

    until (period == p) do
      period += 1
      startdate = endate + 1
      if has_leapday?(startdate)
        endate = startdate + 52
      else
        endate = startdate + 51
      end
    end

    return(startdate)
  end 

  def self.period_of(this_pt_in_time, birthdate)
    # Determines which of the 7 periods (starting at birthdate)
    # this_pt_in_time falls within.
    # Returns the period as an integer.

    period = 1

    if this_pt_in_time == birthdate
      return(period)
    end
    
    startdate = birthdate
    if has_leapday?(startdate)
      endate = startdate += 52
    else
      endate = startdate += 51
    end

    until ((this_pt_in_time >= startdate) && (this_pt_in_time < endate)) do
      period += 1
      if period > 7
        period = 1
      end

      startdate = endate
      if has_leapday?(startdate)
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
