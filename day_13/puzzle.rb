input = File.readlines('input.txt').map { |line| eval(line.strip) unless line.strip.empty? }.compact

indicies_not_in_right_order = []

def comp(left, right)
  left_ptr = 0
  right_ptr = 0

  while left_ptr < left.length && right_ptr < right.length
    left_val = left[left_ptr]
    right_val = right[right_ptr]

    if left_val.is_a?(Integer) && right_val.is_a?(Integer)
      return true if left_val < right_val
      return false if left_val > right_val
    elsif left_val.is_a?(Array) && right_val.is_a?(Array)
      res = comp(left_val, right_val)
      return res unless res.nil?
    elsif left_val.is_a?(Array) && right_val.is_a?(Integer)
      res = comp(left_val, [right_val])
      return res unless res.nil?
    elsif left_val.is_a?(Integer) && right_val.is_a?(Array)
      res = comp([left_val], right_val)
      return res unless res.nil?
    end

    left_ptr += 1
    right_ptr += 1
  end

  return true if left.length < right.length
  return false if left.length > right.length
end

# Part 1
input.each_slice(2).to_a.each_with_index do |pair, idx|
  val = comp(pair[0], pair[1])
  indicies_not_in_right_order << (idx + 1) if val
end

puts indicies_not_in_right_order.sum


# Part 2

input << [[2]]
input << [[6]]

# Bubble Sort :)
loop do
  swapped = false

  i = 1

  while i < input.length
    res = comp(input[i - 1], input[i])

    unless res
      input[i - 1], input[i] = input[i], input[i - 1]
      swapped = true
    end

    i += 1
  end

  break unless swapped
end

vals = []
input.each_with_index do |line, idx|
  vals << idx + 1 if ([[[2]], [[6]]]).include?(line)
end

puts vals[0] * vals[1]
