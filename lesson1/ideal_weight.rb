# Не идеальная программа для вычисление идеального веса

puts "Как тебя зовут?"
name = gets.chomp.capitalize

puts "Напиши свой рост в сантиметрах"
height = gets.chomp

ideal_weight = height.to_i-110

unless ideal_weight<0
	puts "#{name}, привет! Для Вас идеальный вес #{ideal_weight.to_s} кг"
else
	puts "#{name}, привет! Ваш вес уже оптимальный!"
end

