# My initial stack. Also, cleaned up the input file to make it easier to parse.
#
# [P]     [L]         [T]
# [L]     [M] [G]     [G]     [S]
# [M]     [Q] [W]     [H] [R] [G]
# [N]     [F] [M]     [D] [V] [R] [N]
# [W]     [G] [Q] [P] [J] [F] [M] [C]
# [V] [H] [B] [F] [H] [M] [B] [H] [B]
# [B] [Q] [D] [T] [T] [B] [N] [L] [D]
# [H] [M] [N] [Z] [M] [C] [M] [P] [P]
#  1   2   3   4   5   6   7   8   9

input = File.readlines('input.txt')

stacks = {
  1 => %w[H B V W N M L P],
  2 => %w[M Q H],
  3 => %w[N D B G F Q M L],
  4 => %w[Z T F Q M W G],
  5 => %w[M T H P],
  6 => %w[C B M J D H G T],
  7 => %w[M N B F V R],
  8 => %w[P L H M R G S],
  9 => %w[P D B C N]
}

# Part 1
# input.map do |line|
#   count, from, to = line.split
#   stacks[Integer(from)].pop(Integer(count)).reverse!.map { |ele| stacks[Integer(to)].push(ele) }
# end
#
# res = []
# stacks.each { |_i, stack| res << stack.pop }
# puts res.compact.join('')

# Part 2
input.map do |line|
  count, from, to = line.split
  stacks[Integer(from)].pop(Integer(count)).map { |ele| stacks[Integer(to)].push(ele) }
end

res = []
stacks.each { |_i, stack| res << stack.pop }
puts res.join('')
