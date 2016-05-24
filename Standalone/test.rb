#dirty="Hello#$(*  --	 _8754_    Go0dbye"
#puts dirty.gsub(/[-_]/, ' ').gsub(/[^a-zA-Z0-9\s\-\_]/,"")

#words = dirty.gsub(/[^a-zA-Z0-9\s\-]/,"").split()
#words.each { |w|
   #print w, " "
  #}
#puts ""



w = static
wquoted = w.insert(0, \042) << \042
puts wquoted
