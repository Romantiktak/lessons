# Найти порядковый номер даты в году
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts 'Введите год'
year = gets.chomp.to_i
puts 'Введите месяц'
month_input = gets.chomp.to_i
puts 'Введите число'
day_input = gets.chomp.to_i

  if (year % 400).zero?
    months[1] = 29
  elsif (year % 100).zero?
    months[1] = 28
  elsif (year % 4).zero?
    months[1] = 29
  else
    months[1] = 28
  end
count = 0
months.map.with_index do |days_array, i|
  count += days_array if i < month_input - 1
end
count += day_input
puts "Введенная дата будет #{count}-ая в году"
