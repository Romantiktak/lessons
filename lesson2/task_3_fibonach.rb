# Вывод чисел Фибоначи до 100

fibonachi = [0, 1]
loop do
  next_number = fibonachi[-1] + fibonachi[-2]
  break if next_number >= 100
  fibonachi << next_number
end
puts fibonachi
