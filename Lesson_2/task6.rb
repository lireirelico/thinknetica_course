require 'colorize'

TEXT = {
    height_error: 'Не корректный ввод число. Введите положительное число без символов!'.red,
}

def create_products
  products = []
  loop do
    hash = {}
    name = get_value('название товара')
    break unless name
    hash[name] = {}
    hash[name]['price'] = get_value('цену')
    hash[name]['count'] = get_value('количество')
    products << hash
  end
  products
end

def get_value(value)
  loop do
    puts "Введите #{value}:"
    result = gets.chomp
    return false if result[/стоп/]
    case value
    when /цену|количество/
      return result.to_i if check_int?(result)
    else
      return result
    end
  end
end

def check_int?(int)
  unless int[/^\d+$/]
    puts TEXT[:height_error]
    return false
  end
  true
end

def total_amount(hash)
  hash.each do |k, v| puts "#{k}: #{v['price'] * v['count']}"
  end
end

products = create_products
puts "Хэш с продуктами:\n#{products}"
puts "Итоговая сумма за каждый товар:"
products.each do |i|
  total_amount(i)
end