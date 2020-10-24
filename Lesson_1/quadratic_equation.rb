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

def calc_discriminant(a, b, c)
  b**2 - 4 * a * c
end

def get_roots(a, b, discriminant)
  if discriminant < 0
    puts 'Корней нет!'
  else
    c = Math.sqrt(discriminant)
    х1 = (-1 * b + c) / (2 * a)
    x2 = (-1 * b - c) / (2 * a)
    puts "Значение корней: x1=#{х1}, x2=#{x2};\n Дискрминант: D=#{discriminant}"
  end
end

a = get_value('a')
b = get_value('b')
c = get_value('c')
d = calc_discriminant(a, b, c)
get_roots(a, b, d)