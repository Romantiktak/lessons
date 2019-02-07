# Создадим массив букв-символов
alphabet = [*('a'..'z')]
# Создадим hash гласных
vowels = { 'a' => 0, 'e' => 0, 'i' => 0, 'o' => 0, 'u' => 0 }
# Первая буква алфавита соответсвует нулевой в массиве
vowels.each_key do |letter|
  i = alphabet.index(letter) + 1
  vowels[letter] = i
end

puts vowels
