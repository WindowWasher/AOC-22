require 'set'

input = File.readlines('input.txt')

def char_pri(char)
  # a-z 1-26   sub 96
  # A-Z 27-52  sub 38
  #

  return char.ord - 96 if char.ord > 96

  char.ord - 38
end

# Part 1
score = 0

input.each do |line|
  len = line.length
  f = line.slice(0, len / 2)
  l = line.slice(len / 2, len)

  score += char_pri(Set.new(f.each_char).intersection(l.each_char).first)
end

puts score

# Part 2
score = 0

lines_uniq = input.map { |line| Set.new(line.strip.each_char) }
lines_uniq.each_slice(3) do |group|
  score += char_pri(group[0].intersection(group[1]).intersection(group[2]).first)
end

puts score
