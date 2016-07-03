class Numerology
  include ActiveModel::Model
  attr_accessor  :phrase

  VALID_PHRASE_REGEX = /\A[a-zA-Z0-9\s]+\z/

  validates :phrase, presence: true, length: { minimum: 1 },
            format: { with: VALID_PHRASE_REGEX,
            message: "Text to numerically analyze" }

  def self.analysis(phrase)
    # Master function of script, takes as input a string, leverages
    # other functions in script to perform a numerological analysis
    # of the string, and returns the result to standard out.

    phrasetotal = 0
    results = []
    index = 1

    words = clean(phrase).split()
    words.each { |w|
      wrdnum = reduce(convert(w))
      results[index] =  "The word \"#{w}\" is a #{wrdnum}."
      index += 1
      phrasetotal += wrdnum
    }
  
    if words.length > 1
      pt = reduce(phrasetotal)
      results[index] = "The phrase is a #{pt}."
    end

    return(results)
  end

private

#
# Numerology Phrase Calculator Utility, David Herring April 2016
#
# Takes as input a string of characters and performs a numerological
# analysis of them.
#
# This assumes the string of characters will be composed of the
# English alphabet and numbers 1 - 9.
#
# The analysis consists of converting them to their
# corresponding place number in the alphabet (A = 1, B = 2, .. Z = 26),
# adding each character's alphabet place number in the word or phrase
# together to come up with a numeric value. That numeric value is then
# reduced to single digit by repeatedly taking the sum of its digits
# until that sum falls between 1 .. 9.
#
# Example: The string "David" would be analyzed thus:
# D = 4, A = 1, V = 22, I = 9, D = 4.
# 4 + 1 + 22 + 9 + 4 = 40.
# 4 + 0 = 4.
#
# So Numerolocigally, "David" is a "4" and to the practitioner of
# Numerology the number 4 has a significance and meaning that can
# be attibuted to the person who has the name David.
#

def self.letter?(ch)
  # Takes a character and returns true if it's an alpha char.
  ch =~ /[[:alpha:]]/
end

def self.numeric?(ch)
  # Takes a character and returns true if it's a numeric digit.
  ch =~ /[[:digit:]]/
end

def self.clean(strn)
  # Takes a string and returns a string with all non-alpha and
  # non-numeric characters removed. Since - and _ are often used
  # to delimit words, they are changed into spaces.

  return strn.gsub(/[-_]/, ' ').gsub(/[^a-zA-Z0-9\s]/,"")
end

def self.convert(wrd)
  # Takes as input a string and returns its Numerologic integer.
  # Within the confines of this specific use case, it's assumed
  # the input string is a single word from a larger phrase,
  # but that's not a requirement.

  alphabet = ('A'..'Z').to_a
  chars = wrd.upcase.split('')
  total = 0

  chars.each { |c|
    if letter?(c)
      total += (alphabet.index(c).to_i + 1)
    end
    if numeric?(c)
      total += c.to_i
    end
  }

  return total
end

def self.reduce(num)
  # Takes an integer, Numerologically reduces it to a single digit between
  # 1 and 9, returns integer.

  n = num
  dgt = 0

  while n > 9
    digits = n.to_s.split('')
    digits.each { |d|
      dgt += d.to_i
    }
    n = dgt
    dgt = 0
  end

  return n
end

end
