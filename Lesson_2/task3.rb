def fibonacci(number)
  number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
end

arr = []
i = 0
loop do
  number = fibonacci(i)
  break if number > 100
  arr << number
  i += 1
end