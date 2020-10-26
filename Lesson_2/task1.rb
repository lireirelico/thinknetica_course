require 'date'

month = {}
(1..12).each { |i| month[Date::MONTHNAMES[i]] = Date.civil(Date.today.year, i, -1).day }
puts '30 in Month:'
month.each { |month, day| puts month if day == 30 }