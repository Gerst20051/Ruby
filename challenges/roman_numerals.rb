$roman_numerals = {
  'I': 1,
  'IV': 4,
  'V': 5,
  'IX': 9,
  'X': 10,
  'L': 50,
  'C': 100,
  'D': 500,
  'M': 1000,
}

def to_roman(number)
  roman_numeral = ''
  $roman_numerals.reverse_each do |symbol, value|
    count = (number / value).floor
    roman_numeral += symbol.to_s * count
    number -= (count * value)
  end
  roman_numeral
end

puts '8 => ' + to_roman(8) # VIII
puts '9 => ' + to_roman(9) # IX
puts '2021 => ' + to_roman(2021) # MMXXI
