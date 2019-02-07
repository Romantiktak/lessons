products = Hash.new('no product')
loop do
  puts 'Введите название товара или СТОП для выхода'
  product = gets.chomp.downcase!
  break if product == 'стоп'

  puts 'Введите цену товара'
  price = gets.chomp.to_i
  puts 'Введите количество товара'
  count = gets.chomp.to_i
  products[product] = [price, count]
end
puts products
products.each do |name, array|
  sum = array[0] * array[1]
  puts "На покупку #{name} потрачено #{sum}"
end
sum = 0
products.each_value do |array|
  sum += array[0] * array[1]
end
puts 'Сумма всех расходов ' + sum.to_s
