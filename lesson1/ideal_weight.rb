# Не идеальная программа для вычисление идеального веса

puts 'Как тебя зовут?'
name = gets.chomp

puts 'Напиши свой рост в сантиметрах'
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight < 0
  puts "#{name}, привет! Ваш вес уже оптимальный!"
else
  puts "#{name}, привет! Для Вас идеальный вес #{ideal_weight} кг"
end
