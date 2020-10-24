require 'colorize'

TEXT = {
    height_error: 'Не корректный ввод число. Введите положительное число без символов!'.red,
    optimal_weight: 'Ваш вес уже оптимальный!'.green,
    value_error: 'Unsupported value'
}

def get_value(value)
  loop do
    puts "Введите #{value}:"
    result = gets.chomp
    case value
    when /имя/
      return result.capitalize
    when /рост/
      return result.to_i if check_height?(result)
    else
      raise TEXT[:value_error]
    end
  end
end

def check_height?(height)
  unless height[/^\d+$/]
    puts TEXT[:height_error]
    return false
  end
  true
end

def ideal_weight(name, height)
  ideal_weight = (height - 110) * 1.15
  if ideal_weight < 0
    puts TEXT[:optimal_weight]
  else
    puts "#{name}, ваш идеальный вес: #{ideal_weight.round(2)}"
  end
end

puts 'Идеальный вес!'
name = get_value('имя')
height = get_value('рост')
ideal_weight(name, height)