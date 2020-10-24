require 'colorize'

TEXT = {
    height_error: 'Не корректный ввод число. Введите положительное число без символов!'.red,
}

def get_value(value)
  loop do
    puts "Введите #{value.downcase} треугольника:"
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

def calculate_triangle_area(base, height)
  0.5 * base * height
end

base = get_value('основание')
height = get_value('высота')
result = calculate_triangle_area(base, height)
puts "Площадь треугольника: #{result}"
