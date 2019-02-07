# Создадим массив букв-символов
alphabet = "abcdefghijklmnopqrstuvwxyz".split("").map { |letter| letter.intern}
# Создадим список номеров гласных в алфавите
vowels = [1, 5, 9, 15, 21]
# hash для гласных
letter = Hash.new()
# Первая буква алфавита соответсвует нулевой в массиве
vowels.each { |index| letter[index] = alphabet[index-1]}

puts letter
