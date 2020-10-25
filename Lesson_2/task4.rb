hash = {}
('a'..'z').each_with_index { |value, index| hash[value] = index + 1 if value[/[aeiou]/] }
puts hash