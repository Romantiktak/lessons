# Вычисление площади треугольгника

puts "Введите длину основания треугольника"
base_triangle = gets.chomp.to_f

puts "Введите высоту треугольника в тех же единицах измерения"
height_triangle = gets.chomp.to_f

S=base_triangle*height_triangle/2

puts "Высота вашего треугольника равна #{S} квадратных единиц"