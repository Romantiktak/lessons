# Найти порядковый номер даты в году

months = {
  '1' => 31,
  '2' => nil,
  '3' => 31,
  '4' => 30,
  '5' => 31,
  '6' => 30,
  '7' => 31,
  '8' => 31,
  '9' => 30,
  '10' => 31,
  '11' => 30,
  '12' => 31
}

puts 'Введите год'
year = gets.chomp.to_i
puts 'Введите месяц'
month_input = gets.chomp.to_i
puts 'Введите число'
day_input = gets.chomp.to_i

months['2'] = if year % 400 == 0
                29
              elsif year % 100 == 0
                28
              elsif year % 4 == 0
                29
              else
                28
                  end

count = 0
months.each { |month_hash, days_m| count += days_m if month_hash.to_i < month_input }
count += day_input

puts "Введенная дата будет #{count}-ая в году"
