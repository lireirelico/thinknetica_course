#Solution 1
arr = []
i = 10
until i > 100
  arr << i
  i += 5
end

#Solution 2
arr = []
(10..100).each { |i| arr << i if i % 5 == 0 }

#Solution 3
(10..100).step(5).to_a