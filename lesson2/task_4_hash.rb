# Создадим массив букв-символов
alphabet = [*('a'..'z')]
# Создадим hash гласных
vowels = [ 'a', 'e' , 'i' , 'o', 'u' ]
# Первая буква алфавита соответсвует нулевой в массиве
vowels_with_index = {}
vowels.each {|letter| vowels_with_index[letter] = alphabet.index(letter)+1}
puts vowels_with_index
