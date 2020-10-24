require 'colorize'

TEXT = {
    height_error: 'Не корректный ввод число. Введите положительное число без символов!'.red,
}

def get_value(value)
  loop do
    puts "Введите #{value} сторону треугольника:"
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

def input_all_side
  side = []
  3.times { |i| side << get_value(i + 1) }
  side
end

def right_triangle?(sides)
  sides[-1]**2 == sides[0]**2 + sides[1]**2
end

def get_triangle_type(sides)
  case sides.uniq.size
  when 3
    right_triangle?(sides) ? 'прямоугольным' : 'неизвестным'
  when 2
    'равнобедренным'
  when 1
    'равносторонним и равнобедренным'
  else
    'неизвестным'
  end
end

sides = input_all_side
puts "Введенный треугольник является #{get_triangle_type(sides)}"


