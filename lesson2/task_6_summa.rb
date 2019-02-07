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
total = 0
products.each do |name, array|
  sum_product = array[0] * array[1]
  total+=sum_product
  puts "На покупку #{name} потрачено #{sum_product}"
end

puts 'Сумма всех расходов ' + total.to_s
