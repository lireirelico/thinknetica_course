require 'colorize'

TEXT = {
    height_error: 'Не корректный ввод число. Введите положительное число без символов!'.red,
}

def get_value(value)
  loop do
    puts "Введите #{value}:"
    result = gets.chomp
    return result.to_i if check_int?(result)
  end
end

def check_int?(int)
  unless int[/^\d+$/]
    puts TEXT[:height_error]
    return false
  end
  true
end

def leap_year?(year)
  (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

def yday(day, month, year)
  count = 0
  day_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  day_of_month[1] += 1 if leap_year?(year)
  (0...month - 1).each { |i| count += day_of_month[i] }
  count + day
end

day_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day = get_value('число')
month = get_value('месяц')
year = get_value('год')
puts "Порядковый номер даты: #{yday(day, month, year)}"